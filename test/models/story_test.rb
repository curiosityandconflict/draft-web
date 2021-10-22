require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
    should have_many(:outline_items)
  end
end
