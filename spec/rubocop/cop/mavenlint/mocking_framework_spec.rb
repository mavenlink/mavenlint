require 'rubocop/cop/mavenlint/mocking-framework'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::MockingFramework do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when RR is used' do
    expect_offense(<<~RUBY)
      stub(instance).should_email? { true }
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use rspec-mocks
    RUBY
  end

  it 'passes when rspec-mocks is used' do
    expect_no_offenses(<<~RUBY)
      expect(instance).to receve(:should_email?) { true }
    RUBY
  end
end
