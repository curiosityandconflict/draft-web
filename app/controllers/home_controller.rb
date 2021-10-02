class HomeController < ApplicationController
  layout 'home', only: [:index]

  def index 
    @stories = current_user.stories.order(updated_at: :desc).first(3)
  end
end
