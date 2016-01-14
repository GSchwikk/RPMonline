class UsersController < ApplicationController
	before_action :set_user, only: [:show]
	respond_to :html, :json

	def show
		@meetings = Meeting.where(user_id: @user.id)
		@packs = Pack.where(user_id: @user.id)
		@actions = Step.where(user_id: @user.id)
	end

	def index
		@users = User.where(organisation_id: current_user.organisation_id)
		@roles = {"org_owner" => "Organisation Admin","div_owner" => "Division Owner", "meeting_owner" => "Meeting Owner", "pack_owner" => "Pack Owner" }
		@divisions = Division.where(organisation_id: current_user.organisation_id)
		
		@div_users = User.where("role = 'div_owner'")
		@div_collection = @div_users.collect{|user| [user.id,user.first_name + " " + user.last_name]}

		@meeting_users = User.where("role = 'meeting_owner' or role = 'div_owner'")
		@meeting_collection = @meeting_users.collect{|user| [user.id,user.first_name + " " + user.last_name]}

		@user_collection = @users.collect{|user| [user.id,user.first_name + " " + user.last_name]}
	end

	def update
	@user = User.find(params[:id])

	    respond_to do |format|
	      	if @user.update(user_params)
	        	format.json { respond_with_bip(@user) }
	    	end
	    end
	end

  private

	def user_params
	  params.require(:user).permit(:first_name,:last_name, :email, :password, :password_confirmation, :role)
	end

	def set_user
		@user = User.find(params[:id])
	end

end