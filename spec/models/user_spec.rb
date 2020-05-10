# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Model', type: :model do
  let(:stub_user) do
    build_stubbed :user,
                  username: 'renan',
                  full_name: 'Renan',
                  password: '123',
                  email: 'email@hotmail.com'
  end

  context 'when creating a regular user' do
    before(:all) do
      @messages = {
        missing: "can't be blank",
        taken: 'has already been taken',
        format_email: 'requires a valid email format',
        format_full_name: 'requires to have just letters'
      }

      @created_user = create :user,
                             username: 'username',
                             email: 'some@email.com'
    end

    after(:all) { User.destroy_all }

    it 'validates presence of full_name' do
      stub_user.full_name = nil
      stub_user.valid?
      full_name_error = stub_user.errors.messages[:full_name]
      expect(full_name_error).to include(@messages[:missing])
    end

    it 'validates presence of email' do
      stub_user.email = nil
      stub_user.valid?
      email_error = stub_user.errors.messages[:email]
      expect(email_error).to include(@messages[:missing])
    end

    it 'validates presence of password' do
      stub_user.password = nil
      stub_user.valid?
      password_error = stub_user.errors.messages[:password]
      expect(password_error).to include(@messages[:missing])
    end

    it 'validates presence of username' do
      stub_user.username = nil
      stub_user.valid?
      username_error = stub_user.errors.messages[:username]
      expect(username_error).to include(@messages[:missing])
    end

    it 'validates username uniqueness' do
      stub_user.username = @created_user.username
      stub_user.valid?
      username_error = stub_user.errors.messages[:username]
      expect(username_error).to include(@messages[:taken])
    end

    it 'validates email uniqueness' do
      stub_user.email = @created_user.email
      stub_user.valid?
      email_error = stub_user.errors.messages[:email]
      expect(email_error).to include(@messages[:taken])
    end

    it 'allows just letters on full_name' do
      stub_user.full_name = "a/0123456789!@#bs$%^&*()_+-d=}a{][\|:?><'.,;:`~\""
      stub_user.valid?
      full_name_error = stub_user.errors.messages[:full_name]
      expect(full_name_error).to include(@messages[:format_full_name])
    end
    it 'validates email format' do
      stub_user.email = '213i12jkje.jei0'
      stub_user.valid?
      email_error = stub_user.errors.messages[:email]
      expect(email_error).to include(@messages[:format_email])
    end
  end

  describe 'errors check with #errors_by_field' do
    specify 'show one error message in field' do
      MESSAGE = "can't be blank"
      stub_user.email = ''
      stub_user.valid?

      expect(stub_user.errors.messages[:email].length).to be > 1
      expect(stub_user.errors_by_field[:email]).to eq("Email #{MESSAGE}")
    end
  end
end
