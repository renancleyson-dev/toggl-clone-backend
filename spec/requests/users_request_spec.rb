# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users Requests', type: :request do
  include AuthenticationHelper

  before(:all) do
    @created_user = create :user,
                           username: 'username',
                           full_name: 'User',
                           email: 'some@email.com',
                           password: 'p1'
  end

  after(:all) do
    User.destroy_all
  end

  context 'when use POST verb on /users' do
    it 'creates a regular user' do
      @username = 'renan'
      post '/users', params: {
        user: {
          username: @username,
          full_name: 'Renan',
          email: 'renan@email.com',
          password: 'p1',
          password_confirmation: 'p1'
        }
      }
      expect(response).to redirect_to('/login')
      expect(User.exists?(username: @username)).to be true
    end
  end

  context 'when use PUT verb on /users/:id' do
    it 'updates a regular user' do
      sign_in(@created_user)

      @update_hash = { full_name: 'Guy', email: 'e@gmail.com', password: 'p2' }
      put "/users/#{@created_user.id}", params: { user: @update_hash }

      @autheticated_user = User.find(@created_user.id)
                               .authenticate(@update_hash[:password])

      expect(response).to have_http_status(:success)
      expect(@autheticated_user.full_name).to eq(@update_hash[:full_name])
      expect(@autheticated_user.email).to eq(@update_hash[:email])
    end
  end

  context 'when use GET verb on /users/:id' do
    it 'gets a json of a regular user' do
      sign_in(@created_user)
      get "/users/#{@created_user.id}"
      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(@created_user.to_json)
    end
  end
end
