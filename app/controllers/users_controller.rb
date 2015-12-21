class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@meetings = Meeting.where(user_id: @user.id)
		@packs = Pack.where(user_id: @user.id)
		@actions = Step.where(user_id: @user.id)
	end

	def index
		@users = User.where(organisation_id: current_user.organisation_id)
		@roles = {"org_owner" => "Organisation Admin","div_owner" => "Division Owner", "meeting_owner" => "Meeting Owner", "pack_owner" => "Pack Owner" }
	end

end

def user_params
  params.require(:user).permit(:first_name,:last_name, :email, :password, :password_confirmation, :role)
end