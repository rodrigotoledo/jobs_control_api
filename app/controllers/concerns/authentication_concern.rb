# app/controllers/concerns/authentication_concern.rb

module AuthenticationConcern
  extend ActiveSupport::Concern

  private

  def authenticate_user!
    head :forbidden unless user_sign_in?
  end

  def current_user
    Current.user ||= authenticate_user_from_session
  end

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_sign_in?
    current_user.present?
  end

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(user)
    Current.user = nil
    reset_session
  end
end
