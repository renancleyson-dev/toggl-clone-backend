# frozen_string_literal: true

json.array! @time_records do |time_record|
  json.id time_record.id
  json.startTime time_record.start_time
  json.endTime time_record.end_time
  json.tag time_record.tag unless time_record.tag.nil?
  json.label time_record.label unless time_record.label.nil?
end
