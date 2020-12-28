# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TimeRecord Model', type: :model do
  before(:all) do
    @messages = {
      conflict: 'have a time conflict with other records'
    }

    @created_user = create :user,
                           email: 'josep@gmail.com'

    @created_time_record = create :time_record,
                                  start_time: Time.current,
                                  end_time: 1.hour.after,
                                  user: @created_user
  end

  let(:stubbed_time_record) do
    build_stubbed :time_record,
                  start_time: 2.hours.after,
                  end_time: 3.hours.after,
                  user: @created_user
  end

  after(:all) do
    User.destroy_all
    TimeRecord.destroy_all
  end

  example_group 'validation of time conflicts' do
    example 'between an interval and other inside it' do
      stubbed_time_record.start_time = 1.hour.ago
      stubbed_time_record.end_time = 1.hour.after
      stubbed_time_record.valid?
      @error_message = stubbed_time_record.errors.messages[:start_time]
      expect(@error_message).to include(@messages[:conflict])
    end

    example 'between an interval that is inside of another interval' do
      stubbed_time_record.start_time = 30.minutes.after
      stubbed_time_record.end_time = 40.minutes.after
      stubbed_time_record.valid?
      @error_message = stubbed_time_record.errors.messages[:start_time]
      expect(@error_message).to include(@messages[:conflict])
    end

    example 'on a start time that conflicts with some interval' do
      stubbed_time_record.start_time = 10.minutes.after
      stubbed_time_record.end_time = 2.hours.after
      stubbed_time_record.valid?
      @error_message = stubbed_time_record.errors.messages[:start_time]
      expect(@error_message).to include(@messages[:conflict])
    end

    example 'on an end time that conflicts with some interval' do
      stubbed_time_record.start_time = 10.minutes.ago
      stubbed_time_record.end_time = 10.minutes.after
      stubbed_time_record.valid?
      @error_message = stubbed_time_record.errors.messages[:start_time]
      expect(@error_message).to include(@messages[:conflict])
    end

    example 'between a time record and his update' do
      update_valid = @created_time_record.update(start_time: 1.minute.after)
      expect(update_valid).to be true
    end
  end
end
