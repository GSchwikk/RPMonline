class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@packs = Pack.where(user_id: @user.id)
		@actions = Step.where(user_id: @user.id)
	end
end

def user_params
  params.require(:user).permit(:first_name,:last_name, :email, :password, :password_confirmation, :role)
end