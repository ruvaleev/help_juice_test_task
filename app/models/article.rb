# frozen_string_literal: true

class Article < ApplicationRecord
  validates :body, :title, presence: true

  scope :by_title_or_body, ->(query) do
    where('title ILIKE :query OR body ILIKE :query', query: "%#{query}%")
  end
end
