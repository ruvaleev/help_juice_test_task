# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    body { FFaker::Lorem.paragraphs }
    title { FFaker::Lorem.phrase }
  end
end
