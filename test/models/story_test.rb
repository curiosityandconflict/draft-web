require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
    should have_many(:writing_sessions)
    should have_one(:outline)
    should have_many(:outline_items).through(:outline)
  end
end
