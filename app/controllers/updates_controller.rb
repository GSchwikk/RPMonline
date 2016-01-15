class UpdatesController < ApplicationController
  before_action :set_pack
  before_action :set_update, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :pack
  load_and_authorize_resource :update, :through => :pack, param_method: :update_params
  load_and_authorize_resource :update, :through => :meeting, param_method: :meeting_params
  #before_filter :authorize_meeting

 
  def index
    @updates = Update.all
  end


  def show
  end

  def new
    @update = Update.new
  end


  def edit
  end


  def create
    @update = Update.new(update_params)
    @update.pack_id = @pack.id

    case @update.update_type 
    when 'Highlight' 
      @update.update_type_id = 1
    when 'Lowlight'
      @update.update_type_id = 2
    when  'Issue'
      @update.update_type_id = 3
    else
      @update.update_type_id = 4
    end     

    respond_to do |format|
      if @update.save
        format.html { redirect_to pack_path(@pack), notice: 'Update was successfully created.' }
        format.json { render :show, status: :created, location: @update }
      else
        format.html { render :new }
        format.json { render json: @update.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @update.update(params[:update].permit(:text,:update_type,:date))
        format.html { redirect_to pack_path(@pack), notice: 'Pack was successfully updated.' }
        format.json { respond_with_bip(@update)}
      else
        format.html { render :edit }
        format.json { respond_with_bip(@update) }
      end
    end
  end


  def destroy
    @update.destroy
    respond_to do |format|
      format.html { redirect_to pack_path(@pack), notice: 'Update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_update
      @update = Update.find(params[:id])
    end

    def set_pack
      @pack = Pack.find(params[:pack_id])
      @meeting = Meeting.where(meeting_id: @pack.meeting_id)
    end

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to @pack, :alert => exception.message
    end

    def authorize_meeting
      if current_user.role == 'meeting_owner'
        authorize! :manage, (@meeting)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def update_params
      #params.permit(:text, :update_type, :date)
      params.require(:update).permit(:text, :update_type, :date, :pack_id)
    end


end
