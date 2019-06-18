class CocktailsController < ApplicationController

    before_action :authorize!, only: [:create, :update, :destroy]

    def index
        @cocktails = Cocktail.all
        render json: @cocktails.to_json(include: [:ingredients, :cocktail_ingredients]), status: :ok
    end

    def show
        @cocktail = Cocktail.find(params[:id])
        render json: @cocktail.to_json(include: [:likes, :ingredients, :cocktail_ingredients, :reviews=>{include: :comments}]), status: :ok
    end

    def create
        @cocktail = Cocktail.new(cocktail_params)
        @cocktail.user_id = current_user.id
        if params[:cocktail_ingredients].length > 0
            if @cocktail.save
                params[:cocktail_ingredients].each do |i|
                    @ci = CocktailIngredient.new(user_id: @cocktail.user_id, ingredient_id: i[:ingredient], measurement: i[:measurement])
                    @ci.save
                end
                    render json: @cocktails.to_json(include: [:ingredients, :cocktail_ingredients]), status: :ok
            else
                render json: { errors: @cocktail.errors.full_messages }, status: :unprocessable_entity
            end
        elsif params[:cocktail_ingredients].length > 15
            render json: { errors: ["You must have less than 15 ingredients."] }, status: :unprocessable_entity
        else
            render json: { errors: ["You must have ingredients and measurements for them."] }, status: :unprocessable_entity
        end
    end

    def update

    end

    def destroy

    end

    private

    def cocktail_params
        params.require(:cocktail).permit(:user_id, :name, :instructions, :imageUrl, :videoUrl, :glass, :alcoholic, :category, :cocktail_ingredients)
    end
    
end
