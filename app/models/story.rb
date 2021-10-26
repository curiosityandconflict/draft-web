class Story < ApplicationRecord
  # validates_presense_of :title, :user

  belongs_to :user
  has_many :writing_sessions
  has_one :outline
  has_many :outline_items, through: :outline

  def next_outline_item
    outline.outline_items.where(completed: false).order(position: :asc).first if outline
  end
end
