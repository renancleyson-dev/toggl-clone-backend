# frozen_string_literal: true

# basic User model to authetication
class User < ApplicationRecord
  attribute :username, :string
  attribute :full_name, :string
  attribute :email, :string
  attribute :password_digest, :string

  validates :username, uniqueness: true, presence: true
  validates :full_name, presence: true, format: {
    with: /[a-zA-Z]+\z/,
    message: 'requires to have just letters'
  }
  validates :email, uniqueness: true, presence: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'requires a valid email format'
  }

  has_secure_password

  has_many :sessions
  has_many :time_records
end
