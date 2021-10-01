require 'test_helper'
require 'json'

class StoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:bob)
  end

  context '#index' do
    should 'get index' do
      get stories_url
      assert_response :success

      assert_select ".story", count: users(:bob).stories.count+1
    end


  end

  context '#new' do
    should 'get new story form' do
      get new_story_url
      assert_response :success
    end
  end

  context '#create' do
    should 'create a new story' do
      assert_difference('Story.count') do
        post stories_url, params: { story: { title: "New Story Title" } }
      end

      assert_response :see_other
      assert_redirected_to story_url(Story.last)
    end
  end
  
end
