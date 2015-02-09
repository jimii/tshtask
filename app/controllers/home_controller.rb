class HomeController < ApplicationController

  def index
    redirect_to money_index_path and return if user_signed_in?
  end

end
