require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
  end
end
