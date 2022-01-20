# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /' do
    subject(:send_request) { get '/' }

    let(:session_id) { SecureRandom.uuid }

    context 'with session' do
      before { allow(SecureRandom).to receive(:hex).and_return(session_id) }

      it 'set random session id and writes it to user session' do
        send_request
        expect(request.session[:session_id]).to eq(session_id)
      end
    end

    it 'saves session_id between different requests of same user' do
      send_request
      first_session_id = request.session[:session_id]

      get '/?query=123'
      expect(request.session[:session_id]).to eq(first_session_id)
    end
  end
end
