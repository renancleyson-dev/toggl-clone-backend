# frozen_string_literal: true

# Tag model to user categorize time records
class Tag < ApplicationRecord
  attribute :name

  validates :name, presence: true, uniqueness: true

  belongs_to :user, optional: false
  has_and_belongs_to_many :time_records
end
