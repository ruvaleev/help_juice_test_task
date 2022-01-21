# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/requests_shared_examples'
require_relative 'concerns/sessions_shared_context'

RSpec.describe 'ArticleQueries', type: :request do
  describe 'POST /' do
    subject(:send_request) { post '/article_queries', params: params, xhr: true }

    let(:params) { { article_query: queries_params } }
    let(:queries_count) { rand(2..3) }
    let(:queries) { Array.new(queries_count) { FFaker::Lorem.word } }
    let(:queries_params) do
      queries.map.with_index { |body, i| { body: body, created_at: i.seconds.ago.round } }
    end
    let(:timestamps) { queries_params.map { |params_hash| params_hash[:created_at] } }

    it_behaves_like 'returns status', 201

    it 'creates queries with provided queries as :body attribute' do
      expect {
        send_request
      }.to change { ArticleQuery.where(body: queries).count }.by(queries_count)
    end

    it 'creates queries with provided timestamps as :created_at attribute' do
      expect {
        send_request
      }.to change { ArticleQuery.where(created_at: timestamps).count }.by(queries_count)
    end

    context 'with session_id' do
      include_context 'with session_id'

      it 'creates queries with user :session_id as :user_id' do
        expect {
          send_request
        }.to change { ArticleQuery.where(user_id: session_id).count }.by(queries_count)
      end

      context 'when record with such user_id and created_at timestamp already exists' do
        let!(:article_query) { create(:article_query, created_at: Time.now.round) }

        let(:new_body) { FFaker::Lorem.phrase }
        let(:queries_params) do
          [{
            body: new_body,
            created_at: article_query.created_at,
            user_id: article_query.user_id
          }]
        end

        it "doesn't create new record" do
          expect { send_request }.not_to change { ArticleQuery.count }
        end

        it "updates existing record with provided body" do
          expect { send_request }.to change { article_query.reload.body }.to(new_body)
        end
      end
    end
  end

  describe 'DELETE /' do
    subject(:send_request) { delete '/article_queries', xhr: true }

    context 'with session_id' do
      include_context 'with session_id'

      let(:user_articles_count) { rand(1..3) }
      let!(:other_user_article_query) { create(:article_query, user_id: SecureRandom.uuid) }

      before { create_list(:article_query, user_articles_count, user_id: session_id) }

      it_behaves_like 'returns status', 200

      it "destroys user's queries" do
        expect { send_request }.to change { ArticleQuery.count }.by(-user_articles_count)
      end

      it "doesn't destroy other user's queries" do
        expect { send_request }.not_to change { other_user_article_query.reload.persisted? }
      end
    end
  end
end
