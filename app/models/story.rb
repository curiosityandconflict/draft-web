class Story < ApplicationRecord
    # validates_presense_of :title, :user

    belongs_to :user
    has_many :writing_sessions
end