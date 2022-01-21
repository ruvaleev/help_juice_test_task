# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:title) }
end
