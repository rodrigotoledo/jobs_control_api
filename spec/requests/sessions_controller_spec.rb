require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create(:user) }

  describe 'POST /sign_in' do
    context 'with valid credentials' do
      it 'logs in the user' do
        post sign_in_path, params: {email: user.email, password: PASSWORD_FOR_USER}
        expect(response).to have_http_status(:created)
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'with invalid credentials' do
      it 'returns unprocessable entity' do
        post sign_in_path, params: {email: user.email, password: '123'}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe 'DELETE /logout' do
    before do
      sign_in user
    end
    it 'logout the user' do
      delete logout_path
      expect(response).to have_http_status(:no_content)
      expect(session[:user_id]).to be_nil
    end
  end
end
