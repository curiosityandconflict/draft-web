require 'test_helper'

class OutlineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  context 'associations' do
    should belong_to(:story)
  end
end
