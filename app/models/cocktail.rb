class Cocktail < ApplicationRecord
    belongs_to :user, optional: true
    has_many :likes
    has_many :reviews
    has_many :cocktail_ingredients
    has_many :ingredients, through: :cocktail_ingredients
end
