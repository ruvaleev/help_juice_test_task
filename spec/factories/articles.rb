# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    body { FFaker::Lorem.paragraph }
    title { FFaker::Lorem.phrase }
  end
end
