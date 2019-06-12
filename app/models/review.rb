class Review < ApplicationRecord
    belongs_to :user
    belongs_to :cocktail, optional: true
    belongs_to :api_cocktail_info, optional: true
    
    has_many :comments
    
    validates :content, presence: true
    validates :rating, presence: true

end
