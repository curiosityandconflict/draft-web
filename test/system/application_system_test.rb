require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :firefox, screen_size: [1400, 1400]
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:bob)
  end

  def teardown
    sign_out users(:bob)
  end

  test 'Create a story and write' do
    visit stories_path
    click_on 'Add a New Story'
    fill_in 'story[title]', with: 'New story title'
    click_on 'Create Story'
    assert_text 'New story title'
    click_on 'New Session'
    fill_in 'composer', with: 'Here is some text'
    send_keys :enter
    within '.text-container' do
      assert_text 'Here is some text'
    end
    within '.word-count' do
      assert_text '4'
    end
    fill_in 'composer', with: 'Here is some more text'
    send_keys :enter
    within '.text-container' do
      assert_text 'Here is some more text'
    end
  end
end
