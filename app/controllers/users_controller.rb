class UsersController < ApplicationController

    before_action :authorize!, only: [:update, :destroy]

    def create
        @user = User.new(user_params)
        @user.img_url = "https://www.gatewaychamber.com/Content/Uploads/ProfilePictures/default-user.png"
        if @user.save
            render json:  @user.to_json(only: [:username, :email, :first_name, :last_name, :birthdate, :bio, :img_url, :created_at],include: [:likes, :cocktails, :reviews=>{include: :comments}]), status: :created
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        @user = User.find(params[:id])
        render json: @user.to_json(only: [:username, :email, :first_name, :last_name, :birthdate, :bio, :img_url, :created_at],include: [:likes, :cocktails, :reviews=>{include: :comments}]), status: :ok
    end

    def update

    end

    def destroy

    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :birthdate, :bio, :password_digest, :img_url)
    end

end
