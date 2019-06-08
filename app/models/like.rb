class Like < ApplicationRecord
    belongs_to :user
    belongs_to :cocktail, optional: true
    belongs_to :api_cocktail_infos, optional: true
end
