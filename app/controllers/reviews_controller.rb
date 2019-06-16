class ReviewsController < ApplicationController

    before_action :authorize!, only: [:update, :destroy, :create]

    def create
        @review = Review.new(review_params)
        @review.user_id = current_user.id
        @user = User.find(current_user.id)
        @review.user_avatar_image = @user.img_url
        if @review.save
            getCocktail(@review)
        else
            render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @review = Review.find(params[:id])
        if current_user.id == @review.user_id
            @user = User.find(current_user.id)
            @review.user_avatar_image = @user.img_url
            @review.content = review_params[:content]
            @review.rating = review_params[:rating]
            if @review.save
                getCocktail(@review)
            else
                render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { errors: ["You are not the owner of this content."] }, status: :unauthorized
        end
    end

    def destroy
        @review = Review.find(params[:id])
        if current_user.id == @review.user_id
            @review.destroy
            getCocktail(@review)
        else
            render json: { errors: ["You are not the owner of this content."] }, status: :unauthorized
        end
    end

    def getCocktail(review)
        if review.api_cocktail_info_id
            @cocktail = ApiCocktailInfo.find(@review.api_cocktail_info_id)
            render json: @cocktail.to_json(include: [:likes, :reviews=>{include: :comments}]), status: :ok
        else
            @cocktail = Cocktail.find(@review.cocktail_id)
            render json: @cocktail.to_json(include: [:likes, :ingredients, :cocktail_ingredients, :reviews=>{include: :comments}]), status: :ok
        end
    end

    private
    
    def review_params
        params.require(:review).permit(:user_id, :cocktail_id, :api_cocktail_info_id, :content, :rating, :user_name, :user_avatar_image)
    end
    
end
