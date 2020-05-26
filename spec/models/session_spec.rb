# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Session Model', type: :model do
  before(:all) do
    @created_user = create :user,
                           username: 'alan',
                           full_name: 'Alan',
                           email: 'alan@gmail.com'
  end

  after(:all) do
    User.delete_all
  end

  let(:stub_session) do
    build_stubbed :session, user: @created_user
  end

  context 'when creating a session' do
    before(:all) do
      @messages = {
        missing: "can't be blank",
        missing_user: 'must exist'
      }
    end

    it 'validates the presence of an user_id' do
      stub_session.user_id = nil
      stub_session.valid?
      @user_id_error = stub_session.errors.messages[:user]
      expect(@user_id_error).to include(@messages[:missing_user])
    end

    it 'token is read only' do
      expect { stub_session.token = 'a' }.to raise_error(NoMethodError)
      expect { stub_session.token }.not_to raise_error
    end
  end
end
