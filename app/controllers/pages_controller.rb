class PagesController < ApplicationController
  
  def about
  end

  def contact
  end

  def home
  	@pack = Pack.where(user_id: current_user.id).first
  end

end
