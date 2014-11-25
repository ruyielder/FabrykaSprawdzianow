class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class InvalidUserData < StandardError
  end

  rescue_from InvalidUserData, :with => :display_user_error
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def not_found
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end

  def display_user_error
    render :file => 'public/400.html', :status => 400, :layout => false
  end
end
