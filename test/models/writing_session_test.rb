require 'test_helper'

class WritingSessionTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
    should belong_to(:story).optional(true)
  end

  context "#calculate_word_count" do
    should "calculates word_count" do
      writing_session = WritingSession.new(text: "Here is some cool words to count")

      assert_equal 7, writing_session.calculate_word_count
    end
  end
end
