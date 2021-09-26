require 'test_helper'

class WritingSessionTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
    should belong_to(:story).optional(true)
  end
end
