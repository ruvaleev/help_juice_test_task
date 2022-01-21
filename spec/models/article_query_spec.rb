# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticleQuery, type: :model do
  subject(:article_query) { build(:article_query) }

  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_uniqueness_of(:created_at).scoped_to(:user_id) }
end
