# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AutheticationSystem', type: :system do
  before do
    driven_by(:rack_test)
  end

  before(:all) do
    # Variable to put on password and password_confirmation To avoid mistyping
    @password = 'some password'

    @messages_sign_up = {
      username_used: 'Username has already been taken',
      email_used: 'Email has already been taken',
      wrong_email_format: 'Email requires a valid email format',
      wrong_full_name_format: 'Full name requires to have just letters',
      passwords_has_no_match: "Password confirmation doesn't match Password",
      created: 'User has been successfully created'
    }

    @created_user = create :user,
                           username: 'username',
                           full_name: 'User',
                           email: 'some@email.com',
                           password: 'password'
  end

  after(:all) do
    User.destroy_all
  end

  context 'when sign up' do
    it 'alerts if username or email is already used' do
      visit '/sign_up'
      fill_in 'user_username', with: @created_user.username
      fill_in 'user_full_name', with: 'Renan Cleyson'
      fill_in 'user_email', with: @created_user.email
      fill_in 'user_password', with: @password
      fill_in 'user_password_confirmation', with: @password
      click_button('commit')

      expect(page).to have_text(@messages_sign_up[:username_used])
      expect(page).to have_text(@messages_sign_up[:email_used])
    end

    it 'alerts if email is in wrong format' do
      visit '/sign_up'
      fill_in 'user_username', with: 'renancleyson'
      fill_in 'user_full_name', with: 'Renan Cleyson'
      fill_in 'user_email', with: 'renancleysonhotmailcom'
      fill_in 'user_password', with: @password
      fill_in 'user_password_confirmation', with: @password
      click_button('commit')

      expect(page).to have_text(@messages_sign_up[:wrong_email_format])
    end

    it 'alerts if full name have non alphabetic characters' do
      WRONG_FULL_NAME_FORMAT = "a/0123456789!@#bs$%^&*()_+-d=}a{][|:?><'.,;:`~"

      visit '/sign_up'
      fill_in 'user_username', with: 'renancleyson'
      fill_in 'user_full_name', with: WRONG_FULL_NAME_FORMAT
      fill_in 'user_email', with: 'renancleysonhotmailcom'
      fill_in 'user_password', with: @password
      fill_in 'user_password_confirmation', with: @password
      click_button('commit')

      expect(page).to have_text(@messages_sign_up[:wrong_full_name_format])
    end

    it "alerts if password and password_confirmation fields don't match" do
      visit '/sign_up'
      fill_in 'user_username', with: 'someguy'
      fill_in 'user_full_name', with: 'Some Guy'
      fill_in 'user_email', with: 'guy@email.com'
      fill_in 'user_password', with: 'staticx'
      fill_in 'user_password_confirmation', with: 'hsaghsaghs'
      click_button('commit')

      expect(page).to have_text(@messages_sign_up[:passwords_has_no_match])
    end

    it 'saves data in database if successful' do
      USERNAME = 'renancleyson'

      visit '/sign_up'
      fill_in 'user_username', with: USERNAME
      fill_in 'user_full_name', with: 'Renan Cleyson'
      fill_in 'user_email', with: 'renancleyson@hotmail.com'
      fill_in 'user_password', with: @password
      fill_in 'user_password_confirmation', with: @password
      click_button('commit')

      expect(User.exists?(username: USERNAME)).to be true
    end
  end

  context 'when autheticating' do
    it 'alerts if username is wrong' do
      visit '/'
      fill_in 'username', with: 'wrongusername'
      fill_in 'password', with: 'wrongpassword'
      click_button('commit')
      expect(page).to have_text("Username or password don't match")
    end
  end
end
