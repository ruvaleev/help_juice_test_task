# frozen_string_literal: true

# This model we need only because its impossible to use InfluxDB on Heroku, while we need persistent statistics data
class ArticleQuery < ApplicationRecord
  validates :body, :user_id, presence: true
  validates_uniqueness_of :created_at, scope: :user_id

  scope :statistics_by_session_id, ->(session_id) do
    where(user_id: session_id).group(:body).order(count_all: :desc).count.keys.first(STATISTICS_LIMIT)
  end

  STATISTICS_LIMIT = 5
end
