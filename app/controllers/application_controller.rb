class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter :authenticate_traveller!
  
  private
  def authenticate_user!
    redirect_to root_url if current_traveller.nil?
  end 
end
