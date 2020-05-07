# frozen_string_literal: true

require 'bcrypt'

# Basic User model to authetication
class User < ActiveRecord::Base
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'requires a valid email format'
  }

  has_secure_password
end
