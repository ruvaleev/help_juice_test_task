# frozen_string_literal: true

# This model we need only because its impossible to use InfluxDB on Heroku, while we need persistent statistics data
class ArticleQuery < ApplicationRecord
  validates :body, :user_id, presence: true
  validates_uniqueness_of :created_at, scope: :user_id
end
