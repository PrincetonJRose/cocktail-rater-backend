class IngredientsController < ApplicationController

    before_action :authorize!, only: [:create, :update, :destroy]

    def index
        @ingredients = Ingredient.all
        render json: @ingredients, status: :ok
    end

    def show
        @ingredient = Ingredient.find_by(id: params[:id])
        render json: @ingredient, status: :ok
    end

    def create
        
    end

    private

    def ingredient_params

    end

end
