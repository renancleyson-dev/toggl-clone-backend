# frozen_string_literal: true

# Project model to user categorize time records
class Project < ApplicationRecord
  attribute :name
  attribute :color

  belongs_to :user
  has_many :time_records
end
