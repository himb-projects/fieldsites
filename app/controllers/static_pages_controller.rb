class StaticPagesController < ApplicationController

  def home
    @sites = Site.all
    if logged_in?
    end
  end

end
