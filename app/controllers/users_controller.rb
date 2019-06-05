class UsersController < ApplicationController

    # before_action :authorize!, only: [:update, :delete]

    def create
        @user = User.new(user_params)
        if @user.save!
            render json: { flash: "Account created!!!" }, status: :ok
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :first_name, :last_name, :birthdate, :bio)
    end

end
