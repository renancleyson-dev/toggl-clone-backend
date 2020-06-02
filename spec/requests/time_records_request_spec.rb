# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TimeRecords API', type: :request do
  include AuthenticationHelper

  before(:all) do
    @created_user = create :user,
                           username: 'username',
                           full_name: 'User',
                           email: 'some@email.com',
                           password: 'p1'

    @created_time_record = create :time_record,
                                  start_time: 2.minutes.ago,
                                  end_time: 1.minute.ago,
                                  user: @created_user
  end

  before { sign_in(@created_user) }

  after(:all) do
    User.destroy_all
    TimeRecord.destroy_all
  end

  context 'when call a GET verb' do
    it "responses with the user's time records as json" do
      get "/users/#{@created_user.id}/time_records"

      created_record_result = {
        start_time: @created_time_record.start_time,
        end_time: @created_time_record.end_time
      }
      deserialized_data = JSON.parse(response.body)['data']
      expect(deserialized_data).to include(created_record_result.as_json)
    end
  end

  context 'when call a POST verb' do
    it 'creates a time record on database' do
      @start_time = Time.current
      @end_time = 1.hour.after

      post "/users/#{@created_user.id}/time_records", params: {
        time_record: {
          start_time: @start_time,
          end_time: @end_time
        }
      }

      expect(TimeRecord.exists?(end_time: @end_time.to_s)).to be true
    end
  end

  context 'when call a PUT verb on .../:time_record_id' do
    it 'updates the start_time or end_time' do
      @update_hash = { start_time: 30.minutes.after, end_time: 1.hour.after }
      put "/users/#{@created_user.id}/time_records/#{@created_time_record.id}",
          params: { time_record: @update_hash }

      @updated_record = TimeRecord.find(@created_time_record.id)
      expect(@updated_record.start_time.to_s)
        .to eq(@update_hash[:start_time].to_s)
      expect(@updated_record.end_time.to_s).to eq(@update_hash[:end_time].to_s)
    end
  end

  context 'when call a GET verb on .../:days' do
    it 'responses with all records of days ago' do
      @out_of_limit_record = create :time_record,
                                    start_time: 10.days.ago,
                                    end_time: 9.days.ago,
                                    user: @created_user

      created_record_result = {
        start_time: @created_time_record.start_time,
        end_time: @created_time_record.end_time
      }
      out_of_limit_record_result = {
        start_time: @out_of_limit_record.start_time,
        end_time: @out_of_limit_record.end_time
      }

      get "/users/#{@created_user.id}/time_records/8"
      deserialized_data = JSON.parse(response.body)['data']
      expect(deserialized_data).to include(created_record_result.as_json)
      expect(deserialized_data).not_to include(out_of_limit_record_result.as_json)
    end
  end
end
