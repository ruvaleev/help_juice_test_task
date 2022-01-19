# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/requests_shared_examples'

RSpec.describe 'Articles', type: :request do
  describe 'GET /' do
    subject(:send_request) { get '/', params: params, xhr: xhr }

    let(:params) { {} }

    context 'when html request' do
      let(:xhr) { false }

      it_behaves_like 'returns status', 200
    end

    context 'when xhr request' do
      let(:xhr) { true }

      it_behaves_like 'returns status', 200

      context 'when :query param provided' do
        let(:params) { { query: query } }
        let(:query) { SecureRandom.hex }
        let(:articles) { create_list(:article, rand(3..4)) }

        context 'when some of articles has searched value in their body or title' do
          let(:target_title) { "#{FFaker::Lorem.word}#{query}#{FFaker::Lorem.word}" }
          let(:target_body) { "#{FFaker::Lorem.word}#{query}#{FFaker::Lorem.word}" }
          let(:target_articles) { articles.sample(2) }

          before do
            target_articles.first.update(title: target_title)
            target_articles.last.update(body: target_body)
          end

          it 'returns articles with searched values only in @articles variable' do
            send_request
            expect(assigns(:articles).sort).to eq(target_articles.sort)
          end
        end

        context 'when none of articles has searched value in their fields' do
          it 'returns empty array in @articles variable' do
            send_request
            expect(assigns(:articles)).to be_empty
          end
        end
      end
    end
  end
end
