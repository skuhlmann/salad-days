require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end
require 'factory_girl_rails'
require 'faker'
require 'omniauth'
require 'database_cleaner'

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({ provider: "twitter", uid: "testuid", info: { name: "Trevor", location: "Denver" }})

def log_in
  visit root_path
  click_link_or_button "Login with Twitter"
end
