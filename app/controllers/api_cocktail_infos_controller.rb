class ApiCocktailInfosController < ApplicationController
    def index
        @api_cocktails = ApiCocktailInfo.all
        render json: @api_cocktails, status: :ok
    end

    def show
        @cocktail = ApiCocktailInfo.find(params[:id])
        @cocktail
        @info = {}
        

        render json: @cocktail, status: :ok
    end
end
