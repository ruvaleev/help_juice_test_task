# frozen_string_literal: true

# This model we need only because its impossible to use InfluxDB on Heroku, while we need persistent statistics data
class ArticleQuery < ApplicationRecord
  belongs_to :article, counter_cache: :queries_count

  validates :body, :user_id, presence: true
end
