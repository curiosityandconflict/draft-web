require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:stories)
    should have_many(:writing_sessions)
  end
end
