require 'rubocop/cop/mavenlint/use_api_controller'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::UseApiController do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when an api controller directly inherits from ActionController::Base' do
    expect_offense(<<~RUBY)
      class MyController < ActionController::Base; end
                           ^^^^^^^^^^^^^^^^^^^^^^ Controllers should subclass `ApiController`.
    RUBY
  end

  it 'passes when an api controller inherits from ApiController' do
    expect_no_offenses(<<~RUBY)
      class MyController < ApiController; end
    RUBY
  end

  it 'passes when an aoi controller inherits from an other class' do
    expect_no_offenses(<<~RUBY)
      class ApiController < CoolerApiController; end
    RUBY
  end
end
