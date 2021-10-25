class OutlineItemsController < ApplicationController
  before_action :story
  before_action :outline_item, only: [:show, :update, :destroy]

  def new
    @outline_item = @outline.outline_items.new
  end

  def show 
  end

  def create
    @outline.outline_items.create(item_params)

    redirect_to story_outline_path(@story), status: :see_other
  end

  def update
    @outline_item.set_list_position(item_params[:position]) if item_params[:position]
    @outline_item.update item_params

    redirect_to story_outline_path(@story), status: :see_other
  end

  def destroy
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
