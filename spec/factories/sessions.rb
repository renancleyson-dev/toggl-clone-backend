# frozen_string_literal: true

FactoryBot.define do
  factory :session do
    association :user,
                factory: :user,
                username: 'alan',
                full_name: 'Alan',
                email: 'alan@gmail.com',
                password: '123456'
  end
end
