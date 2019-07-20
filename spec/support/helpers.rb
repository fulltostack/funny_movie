require 'support/helpers/validator_helpers'
require 'support/helpers/session_helpers'
RSpec.configure do |config|
  config.include Helpers::ValidatorHelpers
  config.include Helpers::SessionHelpers, type: :feature
end
