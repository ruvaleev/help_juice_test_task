# frozen_string_literal: true

class Article < ApplicationRecord
  validates :body, :title, presence: true
end
