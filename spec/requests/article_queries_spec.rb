# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/requests_shared_examples'

RSpec.describe 'ArticleQueries', type: :request do
  describe 'POST /' do
    subject(:send_request) { post '/article_queries', params: params, xhr: true }

    let(:params) { { article_query: queries_params } }
    let(:article) { create(:article) }
    let(:queries_count) { rand(2..3) }
    let(:queries) { Array.new(queries_count) { FFaker::Lorem.word } }
    let(:queries_params) do
      queries.map { |body| { article_id: article.id, body: body } }
    end

    it_behaves_like 'returns status', 201

    it 'creates queries with provided params for provided article' do
      expect {
        send_request
      }.to change { article.queries.where(body: queries).count }.by(queries_count)
    end

    context 'with session_id' do
      let(:session_id) { SecureRandom.uuid }

      before { allow(SecureRandom).to receive(:hex).and_return(session_id) }

      it 'creates queries with user :session_id as :user_id' do
        expect {
          send_request
        }.to change { article.queries.where(user_id: session_id).count }.by(queries_count)
      end
    end
  end
end
