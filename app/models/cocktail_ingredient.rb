class CocktailIngredient < ApplicationRecord
    belongs_to :cocktail, optional: true, dependent: :destroy
    belongs_to :ingredient, optional: true, dependent: :destroy
end
