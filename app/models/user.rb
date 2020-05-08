# frozen_string_literal: true

require 'bcrypt'

# Basic User model to authetication
class User < ActiveRecord::Base
  validates :username, uniqueness: true, presence: true
  validates :full_name, presence: true, format: {
    with: /[a-zA-Z]+\z/,
    message: 'just letters are allowed'
  }
  validates :email, uniqueness: true, presence: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'requires a valid email format'
  }

  has_secure_password
end
