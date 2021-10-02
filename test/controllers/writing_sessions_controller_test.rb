require 'test_helper'
require 'json'

class WritingSessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:bob)
    @session = writing_sessions(:one)
    @story = stories(:one)
  end

  # test 'should get index' do
  #   get story_writing_sessions_url(@story)
  #   assert_response :success
  # end

  test 'should get new' do
    get new_story_writing_session_url(@story)
    assert_response :success
  end

  test 'should create session' do
    assert_difference('WritingSession.count') do
      post story_writing_sessions_url(@story), params: { session: { text: @session.text, word_count: @session.word_count }  }
    end

    assert_redirected_to edit_story_writing_session_url(@story, WritingSession.last)
  end

  test 'should show session' do
    get story_writing_session_url(@story, @session)
    assert_response :success
  end

  test 'should get edit' do
    get edit_story_writing_session_url(@story, @session)
    assert_response :success
  end

  test 'should update session' do
    patch story_writing_session_url(@story, @session), params: { session: { text: @session.text, word_count: @session.word_count }, story_id: @story.id }
    assert_response :success
  end

  test 'should destroy session' do
    assert_difference('WritingSession.count', -1) do
      delete story_writing_session_url(@story, @session)
    end

    assert_redirected_to story_writing_sessions_url(@story)
  end

  test 'should get word count' do
    get word_count_story_writing_sessions_url(@story), xhr: true

    assert_response :ok
    assert_equal 102, JSON.parse(@response.body)['word_count']
  end

  test 'should protect viewing writing sessions from other users' do
    sign_in users(:jane)

    get story_writing_session_url(@story, @session)
    assert_redirected_to root_path
  end

  test 'should protect edit writing sessions from other users' do
    sign_in users(:jane)

    get edit_story_writing_session_url(@story, @session)
    assert_redirected_to root_path
  end

  test 'should not allow admin to view writing sessions from other users' do
    sign_in users(:admin)

    get story_writing_session_url(@story, @session)
    assert_redirected_to root_path
  end

  test 'should not allow admin to edit writing sessions from other users' do
    sign_in users(:admin)

    get edit_story_writing_session_url(@story, @session)
    assert_redirected_to root_path
  end
end
