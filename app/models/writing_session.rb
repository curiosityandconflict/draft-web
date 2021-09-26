class WritingSession < ApplicationRecord
    belongs_to :user
    belongs_to :story, optional: true
end
