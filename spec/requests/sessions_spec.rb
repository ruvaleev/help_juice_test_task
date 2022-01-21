# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/sessions_shared_context'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /' do
    subject(:send_request) { get '/' }

    context 'with session' do
      include_context 'with session_id'

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
