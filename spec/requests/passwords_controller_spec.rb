require 'rails_helper'

RSpec.describe 'PasswordsController', type: :request do
  let!(:user) { create(:user) }
  let(:valid_params) { { user: { password: 'new_password', password_confirmation: 'new_password', password_challenge: 'password123' } } }

  describe 'PUT passwords/update' do
    before do
      sign_in user
    end
    context 'with valid parameters' do
      it 'updates the password and returns a success response' do
        put update_password_path, params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { user: { password: 'new_password', password_confirmation: 'wrong_password', password_challenge: 'current_password' } } }

      it 'does not update the password and returns an error response' do
        put update_password_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
