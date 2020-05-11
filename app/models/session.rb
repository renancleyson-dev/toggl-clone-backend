# frozen_string_literal: true

# session model to authetication
class Session < ApplicationRecord
  validates :token, presence: true, uniqueness: true
  belongs_to :user

  before_validation :set_token, on: :create

  def self.sweep(time = 1.hour)
    if time.is_a?(String)
      time = time.split.inject { |count, unit| count.to_i.send(unit) }
    end

    query = "updated_at < '#{time.ago.to_s(:db)}' OR
    created_at < '#{2.days.ago.to_s(:db)}'"

    where(query).delete_all
  end

  private

  def set_token
    self[:token] = SecureRandom.uuid
  end

  def token=(val)
    self[:token] = val
  end
end
