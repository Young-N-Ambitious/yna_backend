class Api::V1::UsersController < ApplicationController
 # before_action :authenticate_user!, only: [:update, :destroy] 
   
    def index
        users = User.all
        render json: users
    end

    def create
        user = User.create(user_params)
        if user.save
        render json: user, status: :created
        else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def update
        if current_user.update(user_params)
        render json: current_user, status: :ok
        else
        render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(params[:id])
        render json: user
    end
    
    def destroy
        current_user.destroy
        head :no_content
    end
    
    private
    
    def user_params
        params.require(:user).permit(:email, :password)
    end
      
      
end
