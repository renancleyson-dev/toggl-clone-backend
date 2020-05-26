# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions Requests', type: :request do
  context 'when logged in' do
    it 'gives token to session hash and redirects to app' do
      @user = create :user, username: 'Renan Cleyson', password: '123456'
      post '/sessions', params: {
        username: @user.username,
        password: @user.password
      }
      @stored_session = Session.find_by(user: @user)

      expect(session[:token]).to eq(@stored_session.token)
      expect(response).to redirect_to('/app/dashboard')
    end
  end

  context 'in authorization'
end
