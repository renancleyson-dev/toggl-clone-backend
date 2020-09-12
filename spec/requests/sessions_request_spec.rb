# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions Requests', type: :request do
  context 'when logged in' do
    it 'creates a session and gives jwt token in response body' do
      @user = create :user, username: 'Renan Cleyson', password: '123456'
      post '/sessions', params: {
        username: @user.username,
        password: @user.password
      }
      @stored_session = Session.find_by(user: @user)

      expect(@stored_session.token).to eq(response.body.token)
    end
  end

  context 'in authorization'
end
