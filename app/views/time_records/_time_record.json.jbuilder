# frozen_string_literal: true

json.id time_record.id
json.duration time_record.interval
json.start_time time_record.start_time
json.end_time time_record.end_time
json.tags time_record.tags
json.label time_record.label unless time_record.label.nil?

json.project do
  json.extract! time_record.project, :id, :name, :color if time_record.project.present?
end
