# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Model', type: :model do
  context 'when creating a regular user' do
    ERROR_MESSAGES = {
      missing: "can't be blank",
      taken: 'has already been taken',
      format_email: 'requires a valid email format',
      format_full_name: 'just letters are allowed'
    }.freeze

    before(:all) do
      @created_user = create :user,
                             username: 'username',
                             email: 'some@email.com'
    end

    after(:all) { User.destroy_all }

    let(:stub_user) do
      USER_DATA = {
        username: 'renan',
        full_name: 'Renan',
        password: '123',
        email: 'email@hotmail.com'
      }.freeze

      build_stubbed :user, USER_DATA
    end

    it 'validates presence of full_name' do
      stub_user.full_name = nil
      stub_user.valid?
      email_error = stub_user.errors.messages[:full_name]
      expect(email_error).to include(ERROR_MESSAGES[:missing])
    end

    it 'validates presence of email' do
      stub_user.email = nil
      stub_user.valid?
      email_error = stub_user.errors.messages[:email]
      expect(email_error).to include(ERROR_MESSAGES[:missing])
    end

    it 'validates presence of password' do
      stub_user.password = nil
      stub_user.valid?
      password_error = stub_user.errors.messages[:password]
      expect(password_error).to include(ERROR_MESSAGES[:missing])
    end

    it 'validates presence of username' do
      stub_user.username = nil
      stub_user.valid?
      username_error = stub_user.errors.messages[:username]
      expect(username_error).to include(ERROR_MESSAGES[:missing])
    end

    it 'validates username uniqueness' do
      stub_user.username = @created_user.username
      stub_user.valid?
      error = stub_user.errors.messages[:username]
      expect(error).to include(ERROR_MESSAGES[:taken])
    end

    it 'validates email uniqueness' do
      stub_user.email = @created_user.email
      stub_user.valid?
      error = stub_user.errors.messages[:email]
      expect(error).to include(ERROR_MESSAGES[:taken])
    end

    it 'allows just letters on full_name' do
      stub_user.full_name = "a/0123456789!@#bs$%^&*()_+-d=}a{][\|:?><'.,;:`~\""
      stub_user.valid?
      error = stub_user.errors.messages[:full_name]
      expect(error).to include(ERROR_MESSAGES[:format_full_name])
    end
    it 'validates email format' do
      stub_user.email = '213i12jkje.jei0'
      stub_user.valid?
      error = stub_user.errors.messages[:email]
      expect(error).to include(ERROR_MESSAGES[:format_email])
    end
  end
end
