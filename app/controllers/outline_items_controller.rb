class OutlineItemsController < ApplicationController
  before_action :story
  before_action :outline_item, only: [:show, :update, :destroy]

  def new
    unless can? :create, @story
      redirect_to_home
    end
    @outline_item = @outline.outline_items.new
  end

  def show
    unless can? :read, @story
      redirect_to_home
    end
  end

  def create
    unless can? :create, @story
      redirect_to_home
    end

    item_params[:text].each_line do |text|
      @outline.outline_items.create(text: text) if text.present?
    end

    redirect_to story_outline_path(@story), status: :see_other
  end

  def update
    unless can? :update, @story
      redirect_to_home
    end
    if item_params[:text].empty?
      @outline_item.destroy
    else
      @outline_item.set_list_position(item_params[:position]) if item_params[:position]
      @outline_item.update item_params
    end

    redirect_to story_outline_path(@story), status: :see_other
  end

  def destroy
    unless can? :destroy, @story
      redirect_to_home
    end
    @outline_item.destroy
    head :ok
  end

  private

  def item_params 
    params.require(:outline_item).permit(:text, :completed, :position)
  end

  def story
    @story = Story.find(params[:story_id])
    if @story.outline
      @outline = @story.outline
    else
      @outline = Outline.create(story_id: @story.id)
    end
  end

  def outline_item
    @outline_item = OutlineItem.find(params[:id])
  end
end
