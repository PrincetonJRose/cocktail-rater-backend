class CommentsController < ApplicationController
    
    before_action :authorize!, only: [:create, :update, :destroy]

    def create

    end

    def update

    end

    def destroy

    end

    private

    def comment_params

    end
    
end
