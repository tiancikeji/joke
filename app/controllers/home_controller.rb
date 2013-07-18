class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def mobile
    render :layout => false
  end
end
