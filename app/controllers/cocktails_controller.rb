class CocktailsController < ApplicationController

    before_action :authorize!, only: [:create, :update, :destroy]

    def index
        @cocktails = Cocktail.all
        render json: @cocktails.to_json(include: [:ingredients, :cocktail_ingredients]), status: :ok
    end

    def show
        @cocktail = Cocktail.find_by(id: params[:id])
        render json: @cocktail.to_json(include: [:likes, :ingredients, :cocktail_ingredients, :reviews=>{include: :comments}]), status: :ok
    end

    def create
        @cocktail = Cocktail.new(cocktail_params)
        @cocktail.user_id = current_user.id
        if params[:ingredients].length > 0
            if @cocktail.save
                for index in 0...params[:ingredients].length
                    @ci = CocktailIngredient.new(cocktail_id: @cocktail.id, ingredient_id: params[:ingredients][index][:id], measurement: params[:measurements][index])
                    @ci.save
                end
                @cocktails = Cocktail.all
                    render json: @cocktails.to_json(include: [:ingredients, :cocktail_ingredients]), status: :ok
            else
                render json: { errors: @cocktail.errors.full_messages }, status: :unprocessable_entity
            end
        elsif params[:ingredients].length > 15
            render json: { errors: ["You must have less than 15 ingredients."] }, status: :unprocessable_entity
        else
            render json: { errors: ["You must have ingredients and measurements for them."] }, status: :unprocessable_entity
        end
    end

    def update
        @cocktail = Cocktail.find_by(id: params[:id])
        @cocktail.name = cocktail_params[:name]
        @cocktail.instructions = cocktail_params[:instructions]
        @cocktail.videoURL = cocktail_params[:videoUrl]
        @cocktail.imageUrl = cocktail_params[:imageUrl]
        @cocktail.glass = cocktail_params[:glass]
        @cocktail.category = cocktail_params[:category]
        @cocktail.alcoholic = cocktail_params[:alcoholic]
        if params[:ingredients].length > 0
            if @cocktail.save
                for index in 0...params[:ingredients].length
                    @ci = CocktailIngredient.find_by(id: params[:cocktail_ingredients][index][:id])
                    if @ci
                        @ci.ingredient_id = params[:ingredients][index][:id]
                        @ci.measurement = params[:measurements][index]
                        @ci.save
                    else
                        @ci = CocktailIngredient.new(cocktail_id: @cocktail.id, ingredient_id: params[:ingredients][index][:id], measurement: params[:measurements][index])
                        @ci.save
                    end
                end
                @cocktails = Cocktail.all
                    render json: @cocktails.to_json(include: [:ingredients, :cocktail_ingredients]), status: :ok
            else
                render json: { errors: @cocktail.errors.full_messages }, status: :unprocessable_entity
            end
        elsif params[:ingredients].length > 15
            render json: { errors: ["You must have less than 15 ingredients."] }, status: :unprocessable_entity
        else
            render json: { errors: ["You must have ingredients and measurements for them."] }, status: :unprocessable_entity
        end
    end

    def destroy

    end

    private

    def cocktail_params
        params.require(:cocktail).permit(:user_id, :name, :instructions, :imageUrl, :videoUrl, :glass, :alcoholic, :category, :cocktail_ingredients, :ingredients, :measurements)
    end
    
end
