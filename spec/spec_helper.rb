require 'api_request'
require 'response_helper'
require 'integration_test_formatter'

RSpec.configure do |conf|
  conf.mock_with :rr
  #conf.formatter = IntegrationTestFormatter
  #conf.treat_symbols_as_metadata_keys_with_true_values = true
end
