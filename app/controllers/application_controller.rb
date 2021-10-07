class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  rescue_from CanCan::AccessDenied do |exception|
    puts "CanCan::AccessDenied Exception thrown : message=#{exception.message}"
  end

  def redirect_to_home
    respond_to do |format|
      format.html { redirect_to root_path, error: 'Action failed. You do not have the appropriate access.' }
      # format.json { render json: @session, status: :ok }
    end
  end
end
