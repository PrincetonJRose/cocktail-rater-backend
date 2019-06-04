class SessionsController < ApplicationController
    
    def create
        @user = User.find_by(email: params(:email))
        if @user and @user.authenticate(:password)

        else
            render json: { errors: "Incorrect email or password." }, status: :unauthorized
        end
    end

end
