class ApplicationController < ActionController::Base
  protect_from_forgery

  def auth
  	if session[:user_id]
  		@user = User.find(session[:user_id])
  	else
  		session[:redirect_to] = request.fullpath
  		redirect_to "/login?redirect_to=#{request.fullpath}"
  	end
  end
end
