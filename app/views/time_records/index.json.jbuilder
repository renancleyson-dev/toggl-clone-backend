# frozen_string_literal: true

json.array! @time_records, partial: 'time_records/time_record', as: :time_record
