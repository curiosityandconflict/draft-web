class OutlinesController < ApplicationController
  before_action :story
  before_action :outline


  def show
    unless can? :read, @story
      redirect_to_home
    end
    @next_outline_item = @story.next_outline_item
  end

  private

  def outline
    @outline = Outline.find_by(story_id: params[:story_id]) || Outline.create(story_id: params[:story_id])
  end

  def story
    @story ||= Story.find(params[:story_id])
  end
end
