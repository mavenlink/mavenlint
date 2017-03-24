$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rubocop-mavenlink"

require "rubocop/rspec/support"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.fail_fast = ENV.key? "RSPEC_FAIL_FAST"

  config.disable_monkey_patching!

  config.order = :random

  Kernel.srand config.seed
end
