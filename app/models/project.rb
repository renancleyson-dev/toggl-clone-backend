# frozen_string_literal: true

# Project model to user categorize time records
class Project < ApplicationRecord
  attribute :name
  attribute :color

  validates :name, presence: true, uniqueness: true
  validates :color, presence: true

  belongs_to :user
  has_many :time_records
end
