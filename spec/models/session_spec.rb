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
    it 'token is read only' do
      expect { stub_session.token = 'a' }.to raise_error(NoMethodError)
      expect { stub_session.token }.not_to raise_error
    end
  end
end
