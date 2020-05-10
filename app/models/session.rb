# frozen_string_literal: true

# session model to authetication
class Session < ApplicationRecord
  validates :token, presence: true, uniqueness: true
  belongs_to :user

  before_validation :set_token

  private

  def set_token
    self[:token] = SecureRandom.uuid
  end

  def token=(val)
    self[:token] = val
  end
end
