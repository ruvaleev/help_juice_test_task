# frozen_string_literal: true

FactoryBot.define do
  factory :article_query do
    body { FFaker::Lorem.word }
    user_id { SecureRandom.hex }
  end
end
