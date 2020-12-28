# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Model', type: :model do
  before(:all) do
    @messages = {
      format_email: 'requires a valid email format',
    }

    @created_user = create :user,
                           email: 'some@email.com'
  end

  after(:all) { User.destroy_all }

  let(:stub_user) do
    build_stubbed :user,
                  password: '123',
                  email: 'email@hotmail.com'
  end

  context 'when creating a regular user' do
    it 'validates email format' do
      stub_user.email = '213i12jkje.jei0'
      stub_user.valid?
      @email_error = stub_user.errors.messages[:email]
      expect(@email_error).to include(@messages[:format_email])
    end
  end
end
