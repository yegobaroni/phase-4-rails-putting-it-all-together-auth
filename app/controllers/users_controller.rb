class UsersController < ApplicationController

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    def show
        # user = User.find_by(id: session[:user_id])
        # @current_user = User.find_by(id: session[:user_id])
        # render json: user
        render json: @current_user
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    
end