# frozen_string_literal: true

# model to record time tracking
class TimeRecord < ApplicationRecord
  attribute :start_time, :datetime
  attribute :end_time, :datetime
  attribute :label, :string

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :check_time_conflicts

  belongs_to :user
  has_and_belongs_to_many :tags

  def self.group_by_date(time_records)
    time_records.group_by do |time_record|
      start_time = time_record.start_time

      if start_time.to_date == Date.current
        'Today'
      elsif start_time.to_date == Date.yesterday
        'Yesterday'
      else
        start_time.strftime('%a, %e %b')
      end
    end
  end

  def interval
    end_time - start_time
  end

  private

  def conflictants_records
    conflict_queries = ['start_time <= :start_time AND end_time >= :start_time',
                        'start_time <= :end_time AND end_time >= :end_time',
                        'start_time > :start_time AND end_time < :end_time']

    conflict_queries.map! { |query| "(#{query})" }

    user.time_records.where(
      "user_id = :user_id AND #{conflict_queries.join(' OR ')}",
      user_id: user_id,
      start_time: start_time,
      end_time: end_time
    ).where.not(id: id)
  end

  def check_time_conflicts
    return if user.nil? || id.nil?

    message = 'have a time conflict with other records'
    conflictant_time_record = conflictants_records

    return errors.add(:start_time, message) if conflictant_time_record.any?
  end
end
