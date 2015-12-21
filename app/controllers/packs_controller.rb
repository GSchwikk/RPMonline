class PacksController < ApplicationController 
  before_action :set_pack, only: [:show, :edit, :update, :destroy]
  before_action :set_meeting, only: [:new, :create, :delete] 
  before_action :check_org 

  load_resource :pack
  before_filter :authorize

  #load_and_authorize_resource param_method: :pack_params
  #load_and_authorize_resource :meeting 
  #load_and_authorize_resource :pack, :through => [:pack, :meeting]


  #before_filter :authorize_meeting
  #before_action :authenticate_user!
  #before_action :check_user, only: [:edit, :update, :destroy]


  # GET /packs
  # GET /packs.json
  def index
    @packs = Pack.all
  end

  # GET /packs/1
  # GET /packs/1.json
  def show
    @updates = Update.where(pack_id: @pack.id).order("created_at DESC")
    @actions = Step.where(pack_id: @pack.id).order("due_date ASC")
    @highlights = Update.where(pack_id: @pack.id).update_type("Highlight").order("date ASC")
    @lowlights = Update.where(pack_id: @pack.id).update_type("Lowlight").order("date ASC")
    @issues = Update.where(pack_id: @pack.id).update_type("Issue").order("date ASC")
    @priorities = Update.where(pack_id: @pack.id).update_type("Priority").order("date ASC")
    @status_values = {"Not yet due" => "Not yet due", "Done" => "Done", "Not Done" => "Not Done"}
    @packstatus_values = {"Ready" => "Ready", "Not Ready" => "Not Ready"}
  end

  # GET /packs/new
  def new
    #@meeting = Meeting.find(params[:meeting_id])
    @pack = Pack.new

  end

  # GET /packs/1/edit
  def edit
  end

  # POST /packs
  # POST /packs.json
  def create
    #@meeting = Meeting.find(params[:meeting_id])
    @pack = Pack.new(pack_params)
    @pack.meeting_id = @meeting.id

    @pack.user_id = current_user.id

    respond_to do |format|
      if @pack.save
        format.html { redirect_to @pack, notice: 'Pack was successfully created.' }
        format.json { render :show, status: :created, location: @pack }
      else
        format.html { render :new }
        format.json { render json: @pack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packs/1
  # PATCH/PUT /packs/1.json
  def update
    respond_to do |format|
      if @pack.update(pack_params)
        format.html { redirect_to @pack, notice: 'Pack was successfully updated.' }
        format.json { respond_with_bip(@pack) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@pack) }
      end
    end
  end

  # DELETE /packs/1
  # DELETE /packs/1.json
  def destroy
    @meeting = Meeting.where(id: params[:meeting_id]) 
    @pack.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Pack was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pack
      @pack = Pack.find(params[:id])
    end

    def set_meeting
       @meeting = Meeting.find(params[:meeting_id])
    end

    #def check_user
    #  unless current_user.admin?
    #    redirect_to root_url, alert: "Sorry, only admins can do that!"
    #  end
    #end

    def check_org
      unless current_user.organisation == @pack.meeting.division.organisation
        redirect_to current_user, :alert => "Sorry, you are not authorised for that"
      end
    end


    rescue_from CanCan::AccessDenied do |exception|
      redirect_to current_user, :alert => exception.message
    end

    def authorize
      raise CanCan::AccessDenied unless can? :manage, @pack, @meeting
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pack_params
      params.require(:pack).permit(:title, :status)
    end
end
