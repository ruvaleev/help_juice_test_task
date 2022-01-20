# frozen_string_literal: true

require 'rails_helper'
require 'database_cleaner/active_record'
require_relative 'helpers'

RSpec.configure do |config|
  Capybara.javascript_driver = :selenium_chrome
  Capybara.server_port = 3100
  Capybara.server = :puma
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
