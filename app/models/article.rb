# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :queries, class_name: :ArticleQuery, dependent: :destroy
  validates :body, :title, presence: true
end
