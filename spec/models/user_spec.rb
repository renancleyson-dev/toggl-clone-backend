# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Model', type: :model do
  before(:all) do
    @messages = {
      format_email: 'requires a valid email format',
      format_full_name: 'requires to have just letters'
    }

    @created_user = create :user,
                           username: 'username',
                           email: 'some@email.com'
  end

  after(:all) { User.destroy_all }

  let(:stub_user) do
    build_stubbed :user,
                  username: 'renan',
                  full_name: 'Renan',
                  password: '123',
                  email: 'email@hotmail.com'
  end

  context 'when creating a regular user' do
    it 'allows just letters on full_name' do
      stub_user.full_name = "a/0123456789!@#bs$%^&*()_+-d=}a{][\|:?><'.,;:`~\""
      stub_user.valid?
      @full_name_error = stub_user.errors.messages[:full_name]
      expect(@full_name_error).to include(@messages[:format_full_name])
    end
    it 'validates email format' do
      stub_user.email = '213i12jkje.jei0'
      stub_user.valid?
      @email_error = stub_user.errors.messages[:email]
      expect(@email_error).to include(@messages[:format_email])
    end
  end

  describe 'errors check with #errors_by_field' do
    specify 'show one error message per field' do
      stub_user.email = ''
      stub_user.valid?
      expect(stub_user.errors.messages[:email].length).to be > 1
      expect(stub_user.errors_by_field[:email]).to eq("Email can't be blank")
    end
  end
end
