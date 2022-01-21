# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:title) }

  describe '.by_title_or_body' do
    subject(:by_title_or_body) { described_class.by_title_or_body(query_string) }

    let(:articles) { create_list(:article, rand(3..4)) }
    let(:query_string) { SecureRandom.hex }
    let(:target_title) { "#{FFaker::Lorem.word}#{query_string}#{FFaker::Lorem.word}" }
    let(:target_body) { "#{FFaker::Lorem.word}#{query_string}#{FFaker::Lorem.word}" }
    let(:target_articles) { articles.sample(2) }
    let(:non_target_articles) { articles - target_articles }

    before do
      target_articles.first.update(title: target_title)
      target_articles.last.update(body: target_body)
    end

    it { is_expected.to be_a(ActiveRecord::Relation) }
    it { is_expected.to include(*target_articles) }
    it { is_expected.not_to include(*non_target_articles) }
  end
end
