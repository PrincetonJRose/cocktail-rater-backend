class SessionsController < ApplicationController
    
    def create
        @user = User.find_by(email: params[:email])
        if @user and @user.authenticate(params[:password])
            jwt_user = JWT.encode({ user_id: @user.id }, "flatiron!", "HS256")
            render json: { jwt_user: jwt_user }, status: :ok
        else
            render json: { errors: "Incorrect email or password." }, status: :unauthorized
        end
    end

end
