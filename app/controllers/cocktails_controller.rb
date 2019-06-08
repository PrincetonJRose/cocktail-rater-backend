class CocktailsController < ApplicationController

    # before_action :authorize!, only: [:create, :update, :delete]

    def index
        @cocktails = Cocktail.all
        render json: @cocktails, status: :ok
    end

    def show
        @cocktail = Cocktail.find(params[:id])
        render json: @cocktail.to_json(include: [:likes, :ingredients, :reviews, :cocktail_ingredients]), status: :ok
    end
    
end
