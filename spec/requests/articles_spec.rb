# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'GET /' do
    subject(:send_request) { get '/', params: params }

    let(:params) { { search_string: search_string } }
    let(:search_string) { SecureRandom.hex }
    let(:target_title) { "#{FFaker::Lorem.word}#{search_string}#{FFaker::Lorem.word}" }
    let(:target_body) { "#{FFaker::Lorem.word}#{search_string}#{FFaker::Lorem.word}" }
    let(:articles) { create_list(:article, rand(3..4)) }
    let(:target_articles) { articles.sample(2) }

    it 'returns 200 status' do
      send_request
      expect(response.status).to eq(200)
    end

    context 'when some of articles has searched value in their body or title' do
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
