# frozen_string_literal: true

# basic User model to authetication
class User < ApplicationRecord
  attribute :email, :string
  attribute :password_digest, :string

  validates :email, uniqueness: true, presence: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'requires a valid email format'
  }

  has_secure_password

  has_many :time_records
  has_many :projects
  has_many :tags
end
