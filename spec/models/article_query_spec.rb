# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticleQuery, type: :model do
  it { is_expected.to belong_to(:article).counter_cache(:queries_count) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:user_id) }
end
