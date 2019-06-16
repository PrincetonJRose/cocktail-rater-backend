class Comment < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :review, optional: true

    validates :content, presence: true

end
