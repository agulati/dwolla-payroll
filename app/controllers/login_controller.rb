class LoginController < ApplicationController
  def index
  	@title = "Please Login"

	if request.post?
		user = User.authenticate(params[:username].downcase, params[:password], request.remote_ip)

		if user
			session[:user_id] = user.id 
			redirect_to (session[:redirect_to] ||= "/company")
		end
	end
  end

  def request_reset
  	@title = "Reset your Password"

	if request.post? and params[:username]
		@reset_user = User.where(:username => params[:username]).first

		if @reset_user.blank?
			@message = { :class => "error", :message => "Username Not Found | Please check your login username" }
		else
			@message = { :class => "success", :message => "Reset Sent | Please check your email for instructions" }

			PasswordMailer.reset(@reset_user).deliver
		end
	end
  end

  def reset
  end
end
