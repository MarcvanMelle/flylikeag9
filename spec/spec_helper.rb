Dir[__dir__ + '/support/*.rb'].each { |file| require_relative file }

require 'devise'
require 'coveralls'
require 'omniauth'
require 'capybara'

Coveralls.wear!('rails')

Capybara.default_host = 'http://localhost:3000'
OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:github,
  {
    uid: "12345",
    info: {
      email: "beetleborgs@gmail.com",
      nickname: "MightyBeetleBorg"
    }
  }
)
OmniAuth.config.add_mock(:facebook,
  {
    uid: "67890",
    info: {
      email: "beetleborgs@gmail.com",
      name: "BigBadBeetleBorgs"
    }
  }
)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include IntegrationSpecHelper, type: :feature
end
