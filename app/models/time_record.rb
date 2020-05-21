# frozen_string_literal: true

# model to record time tracking
class TimeRecord < ApplicationRecord
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :check_time_conflicts

  belongs_to :user

  def interval
    end_time - start_time
  end

  private

  def time_conflict?(variable)
    TimeRecord.where(
      'start_time < :time_variable AND end_time > :time_variable',
      time_variable: variable
    ).exists?
  end

  def check_time_conflicts
    message = 'have a time conflict with other records'
    return errors.add(:start_time, message) if time_conflict?(self[:start_time])
    return errors.add(:end_time, message) if time_conflict?(self[:end_time])

    inside_interval_conflict = TimeRecord.where(
      'start_time > ? AND end_time < ?',
      self[:start_time],
      self[:end_time]
    )
    return errors.add(:start_time, message) if inside_interval_conflict.exists?
  end
end
