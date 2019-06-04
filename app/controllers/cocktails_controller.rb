class CocktailsController < ApplicationController
    def index
        @cocktails = Cocktail.all
        render json: @cocktails, status: :ok
    end

    def show
        @cocktail = Cocktail.find(params[:id])
    end
end
