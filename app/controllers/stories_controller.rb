# frozen_string_literal: true

# controller for stories
class StoriesController < ApplicationController
  load_and_authorize_resource
  before_action :stories
  before_action :writing_sessions, only: %i[show update]

  def index; end

  def new; end

  def create
    @story = current_user.stories.create(story_params)
    @writing_sessions = []

    redirect_to story_path(@story)
  end

  def show
    @word_count_total = @writing_sessions.where.not(word_count: nil).map(&:word_count).sum
    @next_outline_item = @story.next_outline_item
  end

  def edit; end

  def update
    @story.update(story_params)

    render :show
  end

  def destroy
    @story.destroy!

    redirect_to stories_path, status: :see_other
  end

  private

  def story_params
    params.require(:story).permit(:title)
  end

  def stories
    @stories = current_user.stories.order(created_at: :desc)
  end

  def writing_sessions
    @writing_sessions = @story.writing_sessions.order(updated_at: :desc)
  end
end
