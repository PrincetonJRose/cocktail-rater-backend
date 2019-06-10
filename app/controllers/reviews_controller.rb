class ReviewsController < ApplicationController

    # before_action :authorize!, only: [:update, :delete, :create]

    def create

    end

    def update

    end

    def destroy
    
    end

    private
    
    def review_params
        params.require(:review).permit(:user_id, :cocktail_id, :api_cocktail_info_id, :content, :rating,)
    end
    
end
