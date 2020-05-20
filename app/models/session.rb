# frozen_string_literal: true

# session model to authetication
class Session < ApplicationRecord
  validates :token, presence: true, uniqueness: true
  belongs_to :user

  before_validation :set_token, on: :create

  def self.sweep(time = '1 hour')
    time = time.split.inject { |count, unit| count.to_i.send(unit) }
    query = 'updated_at < :time_ago OR created_at < :two_days_ago'

    params = {
      time_ago: time.ago.to_s(:db),
      two_days_ago: 2.days.ago.to_s(:db)
    }

    where(query, params).delete_all
  end

  private

  def set_token
    self[:token] = SecureRandom.uuid
  end

  def token=(val)
    self[:token] = val
  end
end
