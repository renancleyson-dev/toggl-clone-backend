# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users Requests', type: :request do
  before(:all) do
    @created_user = create :user, username: 'username', email: 'some@email.com'
  end

  after(:all) do
    User.destroy_all
  end

  context 'when use post verb on users path' do
    it 'creates a regular user' do
      user_data = attributes_for(:user, username: 'someGuy')
      post '/users', params: { user: user_data }
      expect(response).to redirect_to('/login')
      expect(User.exists?(username: user_data[:username])).to be true
    end
  end

  context 'when use put verb on users/:id path' do
    it 'updates a regular user' do
      update_hash = { email: 'email2@gmail.com', password: 'p2' }
      put "/users/#{@created_user.id}", params: { user: update_hash }
      updated_user = User.find(@created_user.id)
      autheticated_user = updated_user.authenticate(update_hash[:password])

      expect(response).to have_http_status(:success)
      expect(autheticated_user.present?).to be true
    end
  end

  context 'when use get verb on users/:id path' do
    it 'gets a json of a regular user' do
      get "/users/#{@created_user.id}"
      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(@created_user.to_json)
    end
  end
end
