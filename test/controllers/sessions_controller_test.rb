require 'test_helper'
require 'json'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session = sessions(:one)
  end

  test "should get index" do
    get sessions_url
    assert_response :success
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session" do
    assert_difference('Session.count') do
      post sessions_url, params: { session: { text: @session.text, word_count: @session.word_count } }
    end

    assert_redirected_to edit_session_url(Session.last)
  end

  test "should show session" do
    get session_url(@session)
    assert_response :success
  end

  test "should get edit" do
    get edit_session_url(@session)
    assert_response :success
  end

  test "should update session" do
    patch session_url(@session), params: { session: { text: @session.text, word_count: @session.word_count } }
    assert_response :success
  end

  test "should destroy session" do
    assert_difference('Session.count', -1) do
      delete session_url(@session)
    end

    assert_redirected_to archive_sessions_url
  end

  test "should get word count" do
    get word_count_sessions_url, xhr: true

    assert_response :ok
    assert_equal 102, JSON.parse(@response.body)["word_count"]

  end
end
