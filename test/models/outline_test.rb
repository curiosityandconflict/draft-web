require "test_helper"

class OutlineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  context 'associations' do
    should belong_to(:story)
  end
end
