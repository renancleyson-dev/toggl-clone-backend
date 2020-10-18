# frozen_string_literal: true

json.id time_record.id
json.duration time_record.interval
json.start_time time_record.start_time
json.end_time time_record.end_time
json.tag time_record.tag unless time_record.tag.nil?
json.label time_record.label unless time_record.label.nil?
