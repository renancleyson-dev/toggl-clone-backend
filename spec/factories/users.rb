# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'renancleyson' }
    full_name { 'Renan Cleyson' }
    email { 'renancleyson@hotmail.com' }
    password { '123456' }
  end
end
