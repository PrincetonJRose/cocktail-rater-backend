class ReviewsController < ApplicationController

    before_action :authorize!, only: [:update, :delete, :create]

    def create
        @review = Review.new(review_params)
        if @review.save!
            render json: @review, status: :ok
        else
            render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @review = Review.find(params[:id])
        if current_user.id == @review.user_id
            @review.content = review_params[:content]
            @review.rating = review_params[:rating]
            if @review.save!
                render json: @review, status: :ok
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
            render json: status: :ok
        else
            render json: { errors: ["You are not the owner of this content."] }, status: :unauthorized
        end
    end

    private
    
    def review_params
        params.require(:review).permit(:user_id, :cocktail_id, :api_cocktail_info_id, :content, :rating,)
    end
    
end
