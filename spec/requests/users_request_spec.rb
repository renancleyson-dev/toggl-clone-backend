# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users Requests', type: :request do
  include AuthenticationHelper

  before(:all) do
    @created_user = create :user,
                           email: 'some@email.com',
                           password: 'p1'

    @auth_token = sign_in(@created_user)
  end

  after(:all) do
    User.destroy_all
  end

  context 'when use POST verb on /users' do
    it 'creates a regular user' do
      @email = 'renan@email.com'
      post '/users', params: {
        user: {
          email: @email,
          password: 'p1',
          password_confirmation: 'p1'
        }
      }

      expect(response).to have_http_status(:created)
      expect(User.exists?(email: @email)).to be true
    end
  end

  context 'when use PUT verb on /users/:id' do
    it 'updates a regular user' do
      @update_hash = { email: 'e@gmail.com', password: 'p2' }
      put "/users/#{@created_user.id}", params: { user: @update_hash }, headers: {
        'Authorization' => "Bearer #{@auth_token}"
      }

      @autheticated_user = User.find(@created_user.id)
                               .authenticate(@update_hash[:password])

      expect(response).to have_http_status(:success)
      expect(@autheticated_user.email).to eq(@update_hash[:email])
    end
  end

  context 'when use GET verb on /users/:id' do
    it 'gets a json of a regular user' do
      get "/users/#{@created_user.id}", headers: {
        'Authorization' => "Bearer #{@auth_token}"
      }

      show_user = {
        'email' => @created_user.email,
        'id' => @created_user.id
      }
      expect(JSON.parse(response.body)).to eq(show_user)
    end
  end
end
