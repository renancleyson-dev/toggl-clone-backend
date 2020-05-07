# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AutheticationSystem', type: :system do
  before do
    driven_by(:rack_test)
  end

  before(:all) do
    @created_user = create :user, username: 'username', email: 'some@email.com'
  end

  after(:all) do
    User.destroy_all
  end

  FLASH_MESSAGES = {
    created: 'User has been successfully created'
  }.freeze

  context 'when sign up' do
    # Constant to put on password and password_confirmation
    PASSWORD = 'some password'

    it 'alerts if username or email is already' do
      visit '/sign_up'
      fill_in 'username', with: @created_user.username
      fill_in 'email', with: @created_user.email
      fill_in 'password', with: PASSWORD
      fill_in 'passoword-confirmation', with: PASSWORD
      click_button('submit-button')

      expect(page).to have_text(FLASH_MESSAGES[:username_used])
      expect(page).to have_text(FLASH_MESSAGES[:email_used])
    end

    it 'alerts if email is in wrong format' do
      visit '/sign_up'
      fill_in 'username', with: 'renancleyson'
      fill_in 'email', with: 'renancleysonhotmailcom'
      fill_in 'password', with: PASSWORD
      fill_in 'passoword-confirmation', with: PASSWORD
      click_button('submit-button')

      expect(page).to have_text(FLASH_MESSAGES[:wrong_email_format])
    end

    it "alerts if password and password_confirmation fields don't match" do
      visit '/sign_up'
      fill_in 'username', with: 'renancleyson'
      fill_in 'email', with: 'renancleyson@hotmail.com'
      fill_in 'password', with: 'staticx'
      fill_in 'passoword-confirmation', with: 'hsaghsaghs'
      click_button('submit-button')

      expect(page).to have_text(FLASH_MESSAGES[:passwords_has_no_match])
    end

    it 'saves data in database, redirect and notice the user if successful' do
      USERNAME = 'renancleyson'

      visit '/sign_up'
      fill_in 'username', with: USERNAME
      fill_in 'email', with: 'renancleyson@hotmail.com'
      fill_in 'password', with: PASSWORD
      fill_in 'passoword-confirmation', with: PASSWORD
      click_button('submit-button')

      expect(page).to have_current_path('/login')
      expect(page).to have_text(FLASH_MESSAGES[:created])
      expect(User.exists?(username: USERNAME)).to be true
    end
  end

  context 'when autheticating' do
    it "alerts if username and password don't match" do
      visit '/login'
      fill_in 'username', with: 'wrongusername'
      fill_in 'password', with: 'wrongpassword'
      expect(page).to have_text(FLASH_MESSAGES[:wrong_username])
      expect(page).to have_text(FLASH_MESSAGES[:wrong_password])
    end
  end
end
