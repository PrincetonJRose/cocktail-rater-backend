class CommentsController < ApplicationController
    
    before_action :authorize!, only: [:create, :update, :destroy]

    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.user_name = current_user.username
        @comment.user_avatar_image = current_user.img_url
        if @comment.save
            getCocktail(@comment)
        else
            render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @comment = Comment.find(params[:id])
        if current_user.id == @comment.user_id
            @user = User.find(current_user.id)
            @comment.user_avatar_image = @user.img_url
            @comment.content = comment_params[:content]
            if @comment.save
                getCocktail(@comment)
            else
                render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { errors: ["You are not the owner of this content."] }, status: :unauthorized
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        if current_user.id == @comment.user_id
            @comment.destroy
            getCocktail(@comment)
        else
            render json: { errors: ["You are not the owner of this content."] }, status: :unauthorized
        end
    end

    def getCocktail(comment)
        @review = Review.find(comment.review_id)
        if @review.api_cocktail_info_id
            @cocktail = ApiCocktailInfo.find(@review.api_cocktail_info_id)
            render json: @cocktail.to_json(include: [:likes, :reviews=>{include: :comments, :users=>{only: [:username, :user_id, :img_url]}}]), status: :ok
        else
            @cocktail = Cocktail.find(@review.cocktail_id)
            render json: @cocktail.to_json(include: [:likes, :ingredients, :cocktail_ingredients, :reviews=>{include: :comments, :users=>{only: [:username, :user_id, :img_url]}}]), status: :ok
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:user_id, :review_id, :user_avatar_image, :content)
    end
    
end
