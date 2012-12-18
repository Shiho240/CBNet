class UsersController < ApplicationController
before_filter :authenticator, :only => [:edit, :update, :index, :destroy]
before_filter :correct_user,  :only => [:edit, :update]
before_filter :admin_user,    :only => :destroy
def new
    @title = "Sign up"
	@user = User.new
  end
  
def show
	@user = User.find(params[:id])
	@title = @user.username
	@games = @user.games.paginate(:page => params[:page])
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

  def edit
  @user = User.find(params[:id])
  @title = "Edit User Profile"
  end
  
  def update
  @user = User.find(params[:id])
  if @user.update_attributes(params[:user])
	redirect_to @user, :flash => {:success => "Success! Your Profile Has Been Updated"}
  else
	@title = "Edit User Profile"
	render 'edit'
  end
end
 
def index
@users = User.paginate(:page =>1)
@title = "User List"
end

 def destroy
    @user.destroy
    redirect_to users_path, :flash => { :success => "TARGET DESTROYED!" }
end
private

def authenticator
redirect_to login_path, :notice =>"UNAUTHORIZED ACCESS DETECTED, Please sign in to continue!" unless signed_in?
end

def correct_user
	@user = User.find(params[:id])
	redirect_to root_path, :notice => "UNAUTHORIZED ACCESS DETECTED, Editing other user accounts is forbidden" unless current_user?(@user)
end

 def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end
end