# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions Requests', type: :request do
  context 'when logged in' do
    it 'gives user_id key on session hash and redirects to app' do
      user = create :user, username: 'Renan Cleyson', password: '123456'
      user_data = { username: user.username, password: user.password }
      post '/sessions', params: user_data

      expect(session[:user_id]).not_to eq(nil)
      expect(response).to redirect_to('/app/dashboard')
    end
  end

  context 'in authorization' do
  end
end
