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
    end
  end

  context '#create' do
    should 'create a new story' do
      assert_difference('Story.count') do
        post stories_url, params: { story: { title: "New Story Title" } }
      end
    end
  end
  
end
