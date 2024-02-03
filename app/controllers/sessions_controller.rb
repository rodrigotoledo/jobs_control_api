class SessionsController < ApplicationController

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      login(user)
      render json: { user: user }, status: :created
    else
      head :unprocessable_entity
    end
  end

  def destroy
    logout current_user
    head :no_content
  end
end
