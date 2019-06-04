class ApiCocktailInfosController < ApplicationController
    def index
        @api_cocktails = ApiCocktailInfo.all
        render json: @api_cocktails, status: :ok
    end
end
