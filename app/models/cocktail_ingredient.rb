class CocktailIngredient < ApplicationRecord
    belongs_to :cocktail, optional: true
    belongs_to :ingredient, optional: true
end
