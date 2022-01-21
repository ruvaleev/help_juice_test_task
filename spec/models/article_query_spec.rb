# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticleQuery, type: :model do
  subject(:article_query) { build(:article_query) }

  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_uniqueness_of(:created_at).scoped_to(:user_id) }

  describe '.statistics_by_session_id' do
    subject(:statistics_by_session_id) { described_class.statistics_by_session_id(session_id) }

    let(:session_id) { SecureRandom.hex }

    let(:queries_count) { rand(2..3) }
    let!(:user_queries) { create_list(:article_query, queries_count, user_id: session_id) }
    let!(:other_user_query) { create(:article_query) }

    it { is_expected.to be_an(Array) }
    it { is_expected.to include(*user_queries.pluck(:body)) }
    it { is_expected.not_to include(other_user_query) }

    context 'when collection includes doubles' do
      let(:same_body) { SecureRandom.hex }

      before do
        user_queries.last.update(body: same_body)
        user_queries.first.update(body: same_body)
      end

      it "includes only records with uniq bodies" do
        expect(statistics_by_session_id.size).to eq(queries_count - 1)
      end

      it 'still includes all uniq values' do
        expect(statistics_by_session_id).to include(*user_queries.pluck(:body))
      end
    end
  end
end
