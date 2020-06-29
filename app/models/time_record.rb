# frozen_string_literal: true

# model to record time tracking
class TimeRecord < ApplicationRecord
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :check_time_conflicts

  belongs_to :user

  attribute :start_time, :datetime
  attribute :end_time, :datetime
  attribute :label, :string
  attribute :tag, :string

  def interval
    end_time - start_time
  end

  private

  def check_time_conflicts
    return if user.nil?

    message = 'have a time conflict with other records'
    record_owner_query = 'user_id = :user_id'

    conflict_queries = ['start_time <= :start_time AND end_time >= :start_time',
                        'start_time <= :end_time AND end_time >= :end_time',
                        'start_time > :start_time AND end_time < :end_time']

    conflict_queries.map! { |query| "(#{query})" }
    conflictant_time_record = user.time_records.where(
      "#{record_owner_query} AND #{conflict_queries.join(' OR ')}",
      user_id: user_id,
      start_time: start_time,
      end_time: end_time
    )

    unless id.nil?
      conflictant_time_record = conflictant_time_record.filter do |time_record|
        time_record.id != id
      end
    end

    return errors.add(:start_time, message) if conflictant_time_record.any?
  end
end
