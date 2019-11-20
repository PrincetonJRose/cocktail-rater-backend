class ApiCocktailInfosController < ApplicationController
    def index
        @api_cocktails = ApiCocktailInfo.all
        render json: @api_cocktails, status: :ok
    end

    def show
        @cocktail = ApiCocktailInfo.find_by(id: params[:id])
        render json: @cocktail.to_json(include: [:likes, :reviews=>{include: :comments}]), status: :ok
    end
end
