# frozen_string_literal: true

RSpec.shared_examples 'returns status' do |status|
  it "returns status #{ status }" do
    send_request
    expect(response.status).to eq(status)
  end
end

RSpec.shared_examples "doesn't include object to variable" do |variable_name, variable_value, description|
  it "doesn't include #{description} to @#{variable_name} variable" do
    send_request
    expect(assigns(variable_name)).not_to include(send(variable_value))
  end
end

RSpec.shared_examples 'includes object to variable' do |variable_name, variable_value, description|
  it "includes #{description} to @#{variable_name} variable" do
    send_request
    expect(assigns(variable_name)).to include(*[send(variable_value)].flatten)
  end
end
