class PagesController < ApplicationController
  
  def about
  end

  def contact
  end

  def home
  	if user_signed_in?
  		@pack = Pack.find_by(user_id: current_user.id)
  	end
  end

end
