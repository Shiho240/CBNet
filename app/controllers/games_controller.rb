class GamesController < ApplicationController

before_filter :authenticator
before_filter :authorized_user, :only => :destroy
def create
@game = current_user.games.build(params[:game])
if @game.save
redirect_to root_path, :flash => { :success => "Game Ownership/Review Posted!"}
else
@feed_items = []
render 'pages/index'
end
end

def destroy
@game.destroy
redirect_to root_path, :flash => { :success => "Game Ownership/Review Deleted!"}
end

private

def authorized_user
@game = current_user.games.find_by_id(params[:id])
redirect_to root_path if @game.nil?

end

end