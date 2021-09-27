class StoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @stories = @stories.order(created_at: :desc)
  end

  def new
    
  end

  def create
    @story = current_user.stories.create(story_params)

    redirect_to story_path(@story), status: :see_other
  end

  def show

  end

  def update
    @story.update(story_params)
  end

  def destroy
    @story.destroy!
  end

  private

  def story_params
    params.require(:story).permit(:title)
  end
end
