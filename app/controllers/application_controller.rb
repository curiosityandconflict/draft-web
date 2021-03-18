class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    protected

    rescue_from CanCan::AccessDenied do |exception|
        puts "CanCan::AccessDenied Exception thrown : message=#{exception.message}"
    end
end
