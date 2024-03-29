class SessionsController < ApplicationController
  def new
  @title = "Sign In"
  end
  
  def create
  user = User.authenticate(params[:session][:username], params[:session][:password])
	if user.nil?
	flash.now[:error] = "Invalid Username/password"
	render 'new'
	else
		log_in user
		redirect_to user
	end
  end
  
  def destroy
	log_out
	redirect_to root_path
  end
end
