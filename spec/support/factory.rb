require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "jarlax#{n}" }
    sequence(:email) { |n| "jarlax#{n}@launchacademy.com" }
    sequence(:password) { |n| "abcdef1234#{n}" }
    sequence(:password_confirmation) { |n| "abcdef1234#{n}" }
    factory :admin do
      admin true
    end
  end

  # When creating instances, include a user
  factory :word do
    sequence(:word) { |n| "Word#{n}" }
    sequence(:definition) { |n| "Word description#{n}" }
    sequence(:created_at) { |n| n }
  end

  # When creating instances, include a user and a word
  factory :review do
    rating 3
    sequence(:review) { |n| "#{n}This is a short review of a word." }
  end
end
