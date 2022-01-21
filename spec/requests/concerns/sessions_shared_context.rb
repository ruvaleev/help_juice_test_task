# frozen_string_literal: true

RSpec.shared_context 'with session_id' do
  let(:session_id) { SecureRandom.uuid }

  before { allow(SecureRandom).to receive(:hex).and_return(session_id) }
end
