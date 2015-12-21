class MeetingsController < ApplicationController
  load_and_authorize_resource param_method: :meeting_params
  load_and_authorize_resource :meeting, :through => :division, param_method: :division_params
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :set_division, only: [:new, :destroy] 
  before_action :check_org

  def show
    @packs = Pack.where(meeting_id: @meeting.id)
  end

  def new
    @meeting = Meeting.new
  end

  def edit
  end

  def create
    @meeting = Meeting.new(meeting_params)
    #@meeting.division_id = @division.id
    @meeting.user_id = current_user.id

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def set_division
       @division = Division.find(params[:division_id])
    end


    #def check_user
    #  unless current_user.admin?
    #    redirect_to root_url, alert: "Sorry, only admins can do that!"
    #  end
    #end

    def check_org
      unless current_user.organisation == @meeting.division.organisation
        redirect_to current_user, :alert => "Sorry, you are not authorised for that"
      end
    end

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to current_user, :alert => exception.message
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:name, :division_id)
    end
end
