class LikesController < ApplicationController

    before_action :authorize!, only: [:create, :destroy]

    def create
        @like = Like.new(like_params)
        if @like.save
            getCocktail(@like)
        else
            render json: { errors: @like.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @like = Like.find_by(id: params[:id])
        if current_user.id == @like.user_id
            @like.destroy
            getCocktail(@like)
        else
            render json: { errors: ["You are not the owner of this content."] }, status: :unauthorized
        end
    end

    def getCocktail(like)
        if like.api_cocktail_info_id
            @cocktail = ApiCocktailInfo.find(@like.api_cocktail_info_id)
            render json: @cocktail.to_json(include: [:likes, :reviews=>{include: :comments}]), status: :ok
        else
            @cocktail = Cocktail.find(@like.cocktail_id)
            render json: @cocktail.to_json(include: [:likes, :ingredients, :cocktail_ingredients, :reviews=>{include: :comments}]), status: :ok
        end
    end

    private

    def like_params
        params.require(:like).permit(:user_id, :cocktail_id, :api_cocktail_info_id)
    end
    
end
