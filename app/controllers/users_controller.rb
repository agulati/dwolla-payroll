class UsersController < ApplicationController

  before_filter :auth, :except => [:login]

  def login
    redirect_to Dwolla::Client.oauth_authentication_url(request.protocol, request.host_with_port)
  end

  def create
  	@user = User.create(params[:user])
  end

  def edit
  end

  def update
  	@user.update_attributes(params[:user])
  end

  def history

  end
end