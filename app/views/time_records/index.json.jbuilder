# frozen_string_literal: true

json.array! @time_records_grouped.each do |date, time_records_group|
  json.date date
  json.time_records do
    json.array! time_records_group, partial: 'time_records/time_record', as: :time_record
  end
end
