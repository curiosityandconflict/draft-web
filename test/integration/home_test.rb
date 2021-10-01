require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:bob)
  end

  test "show main after sign in" do
    get root_path

    assert_template 'layouts/application'
    # assert_select "a[href=?]", new_story_writing_session_path, count: 1
    assert_select "a[href=?]", stories_path, count: 1
  end

end
