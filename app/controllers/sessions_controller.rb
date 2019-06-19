class SessionsController < ApplicationController
    
    def create  
        @user = User.find_by(email: params[:email])
        if @user and @user.authenticate(params[:password])
            jwt_user = JWT.encode({ user_id: @user.id }, ENV["JWT_AUTH_KEY"], "HS256")
            render json: { jwt_user: jwt_user }, status: :ok
        else
            render json: { errors: ["Invalid email or password."] }, status: :unauthorized
        end
    end

end
