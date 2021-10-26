class OutlineItem < ApplicationRecord
  belongs_to :outline
  acts_as_list scope: :outline
end
