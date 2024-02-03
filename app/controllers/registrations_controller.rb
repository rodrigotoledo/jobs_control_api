class RegistrationsController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      login user
      render json: { user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :full_address, :phone, :cellphone, :address)
  end
end
