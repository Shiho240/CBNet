class PagesController < ApplicationController

  def index
    @title = "Covenant Battle Net"
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