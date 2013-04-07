class UserController < ApplicationController
  before_filter :auth, :except => [:create]

  def create
  	if request.post?
  		@user = User.create(params[:user])
  	end
  end

  def edit
  end

  def update
  	@user.update_attributes(params[:user]) if request.post?
  end

  def history

  end
end
