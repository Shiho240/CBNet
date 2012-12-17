class UsersController < ApplicationController
def new
    @title = "Sign up"
	@user = User.new
  end
  
def show
	@user = User.find(params[:id])
	@title = @user.username
end

def create
    @user = User.new(params[:user])
    if @user.save
	log_in @user
      redirect_to @user, :flash => { :success => "Successfully Created User, Welcome to the Covenant Battle Net, Private!" }
    else
      @title = "Sign up"
      render 'new'
    end
  end

end