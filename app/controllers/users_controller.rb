class UsersController < ApplicationController

  def home

  end

  def login
    redirect_to Dwolla::Client.oauth_authentication_url(request.protocol, request.host_with_port)
  end
end