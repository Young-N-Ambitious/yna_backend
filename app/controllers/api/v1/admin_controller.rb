class Api::V1::AdminController < ApplicationController
    before_action :authenticate_admin!

  def assign_featured_member_role
    user = User.find(params[:user_id])
    if user.add_role(:featured_member)
      render json: { message: 'Featured member role assigned successfully' }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def remove_featured_member_role
    user = User.find(params[:user_id])
    if user.remove_role(:featured_member)
      render json: { message: 'Featured member role removed successfully' }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def authenticate_admin!
    unless current_user.admin?
      render json: { error: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end
  
end
