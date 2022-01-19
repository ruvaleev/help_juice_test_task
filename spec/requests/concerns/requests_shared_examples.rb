# frozen_string_literal: true

RSpec.shared_examples 'returns status' do |status|
  it "returns status #{ status }" do
    send_request
    expect(response.status).to eq(status)
  end
end
