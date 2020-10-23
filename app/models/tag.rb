# frozen_string_literal: true

# Tag model to user categorize time records
class Tag < ApplicationRecord
  attribute :name

  belongs_to :user
  has_and_belongs_to_many :time_records
end
