class PagesController < ApplicationController

  def index
    @title = "Covenant Battle Net"
	if signed_in?
      @game = Game.new
	  @feed_items = current_user.feed.paginate(:page => params[:page])
    end
    end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
  def help
    @title = "Help"
  end
end