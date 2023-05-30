# frozen_string_literal: true

require 'rubocop/cop/mavenlint/use_application_controller'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::UseApplicationController do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when a controller directly inherits from ActionController::Base' do
    expect_offense(<<~RUBY)
      class MyController < ActionController::Base; end
                           ^^^^^^^^^^^^^^^^^^^^^^ Controllers should subclass `ApplicationController`.
    RUBY
  end

  it 'passes when a controller inherits from ApplicationController' do
    expect_no_offenses(<<~RUBY)
      class MyController < ApplicationController; end
    RUBY
  end

  it 'passes when a controller inherits from another class' do
    expect_no_offenses(<<~RUBY)
      class MyController < ApiController; end
    RUBY
  end
end
