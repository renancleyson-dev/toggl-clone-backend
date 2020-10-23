# frozen_string_literal: true

# Project model to user categorize time records
class Project < ApplicationRecord
  has_one :user
  has_many :time_records
end
