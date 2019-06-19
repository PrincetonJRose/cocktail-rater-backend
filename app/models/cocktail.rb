class Cocktail < ApplicationRecord

    belongs_to :user
    has_many :likes
    has_many :reviews
    has_many :cocktail_ingredients
    has_many :ingredients, through: :cocktail_ingredients

    validates :name, presence: true
    validates :alcoholic, presence: true
    validates :category, presence: true
    validates :glass, presence: true
    validates :instructions, presence: true

end
