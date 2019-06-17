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
        @cocktail = Cocktail.new
        if cocktail_params[:ingredients].length > 0 or cocktail_params[:measurements].length > 0
            @cocktail.name = cocktail_params[:name]
            @cocktail.videoUrl = cocktail_params[:videoUrl]
            @cocktail.imageUrl = cocktail_params[:imageUrl]
            @cocktail.glass = cocktail_params[:glass]
            @cocktail.instructions = cocktail_params[:instructions]
            @cocktail.user_id = current_user.id
            @cocktail.alcoholic = cocktail_params[:alcoholic]

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
        params.require(:cocktail).permit(:user_id, :name, :instructions, :imageUrl, :videoUrl, :glass, :alcoholic, :category, :ingredients, :measurements)
    end
    
end
