# frozen_string_literal: true

FactoryBot.define do
  factory :request do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    patronymic { Faker::Name.first_name }
    email { Faker::Internet.email }
    phone_number { 88_005_553_535 }
    weight { 10 }
    length { 120 }
    width { 200 }
    height { 300 }
    point_of_departure { Faker::Address.country }
    destination { Faker::Address.country }
  end
end
