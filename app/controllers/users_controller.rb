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
        @user = User.find_by(id: params[:id])
        render json: @user.to_json(only: [:username, :email, :first_name, :last_name, :birthdate, :bio, :img_url, :created_at],include: [:likes, :cocktails, :reviews=>{include: :comments}]), status: :ok
    end

    def update
        @user = User.find_by(id: params[:id])
        if @user.id == current_user.id
            if @user.authenticate(params[:password])
                @user.first_name = user_params[:first_name]
                @user.last_name = user_params[:last_name]
                @user.img_url = user_params[:img_url]
                @user.bio = user_params[:bio]
                @user.email = user_params[:email]
                @user.username = user_params[:username]
                if @user.save
                    render json: @user.to_json(only: [:username, :email, :first_name, :last_name, :birthdate, :bio, :img_url, :created_at],include: [:likes, :cocktails, :reviews=>{include: :comments}]), status: :ok
                else
                    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
                end
            else
                render json: { errors: ["Password is incorrect."] }, status: :unprocessable_entity
            end
        else
            render json: { errors: ["You are not the owner of this content."] }, status: :unauthorized
        end
    end

    def destroy

    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :birthdate, :bio, :img_url)
    end

end
