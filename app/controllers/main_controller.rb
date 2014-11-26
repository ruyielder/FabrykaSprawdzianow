class MainController < ApplicationController

  def index
    if user_signed_in?
      redirect_to tests_url
    end
  end

end
