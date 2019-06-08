class ApiCocktailInfo < ApplicationRecord
    has_many :likes
    has_many :reviews
end
