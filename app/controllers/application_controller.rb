class ApplicationController < ActionController::Base
  private

  def authenticate_user!
    redirect_to root_url if current_traveller.nil?
  end
end
