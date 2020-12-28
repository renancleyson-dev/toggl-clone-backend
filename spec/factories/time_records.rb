# frozen_string_literal: true

FactoryBot.define do
  factory :time_record do
    start_time { Time.current }
    end_time { 1.hour.after }

    association :user,
                factory: :user,
                email: 'Jose@gmail.com',
                password: '123456'
  end
end
