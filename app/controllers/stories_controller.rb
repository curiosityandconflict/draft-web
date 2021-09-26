class StoriesController < ApplicationController
    before_action :story, only: [:show, :update, :destroy]

    def index 
        @stories = current_user.stories
    end

    def new
        @story = current_user.stories.new
    end

    def create
        @story = current_user.stories.create(story_params)
    end

    def show

    end


    def update
        
    end

    def destroy

    end

    private

    def story_params
        params.require(:story).permit(:title)
    end

    def story
        @story = current_user.stories.find(params[:id])
    end
end
