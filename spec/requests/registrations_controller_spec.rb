require 'rails_helper'

RSpec.describe 'RegistrationsController', type: :request do
  describe 'POST #create' do
    let(:valid_params) do
      {
        user: attributes_for(:user)
      }
    end

    context 'with valid parameters' do
      it 'creates a new user' do
        expect do
          post sign_up_path, params: valid_params
        end.to change(User, :count).by(1)
      end

      it 'logs in the new user' do
        post sign_up_path, params: valid_params
        expect(session[:user_id]).to eq(User.last.id)
      end

      it 'returns a JSON response with the new user' do
        post sign_up_path, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: attributes_for(:user, email: 'invalid-email', full_name: '')
        }
      end

      it 'does not create a new user' do
        expect do
          post sign_up_path, params: invalid_params
        end.not_to change(User, :count)
      end

      it 'returns a JSON response with errors' do
        post sign_up_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
