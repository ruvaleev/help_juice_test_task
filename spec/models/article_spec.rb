# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  it { is_expected.to have_many(:queries).class_name(:ArticleQuery).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:title) }
end
