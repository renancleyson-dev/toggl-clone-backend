# frozen_string_literal: true

# Project model to user categorize time records
class Project < ApplicationRecord
  attribute :name
  attribute :color

  has_one :user
  has_many :time_records
end
