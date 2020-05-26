# frozen_string_literal: true

# basic User model to authetication
class User < ActiveRecord::Base
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

  def errors_by_field
    return nil if valid?

    error_fields = {}
    errors.messages.each do |field, messages|
      formatted_field = field.to_s.split('_').join(' ').capitalize
      error_fields[field] = "#{formatted_field} #{messages[0]}"
    end

    error_fields
  end
end
