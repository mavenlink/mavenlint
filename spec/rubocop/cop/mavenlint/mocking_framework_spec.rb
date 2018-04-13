require 'rubocop/cop/mavenlint/mocking-framework'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::MockingFramework do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  describe 'stubs' do
    describe 'simple examples' do
      it 'detects simple stubs' do
        expect_offense(<<~RUBY)
          stub(instance).should_email? { true }
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use rspec-mocks
        RUBY
      end

      it 'detects simple stubs' do
        expect_offense(<<~RUBY)
          stub(user).is_administrator? { false }
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use rspec-mocks
        RUBY
      end

      it 'passes when rspec-mocks is used' do
        expect_no_offenses(<<~RUBY)
          expect(instance).to receve(:should_email?) { true }
        RUBY
      end

      it 'autocorrects' do
        before = 'stub(instance).should_email? { true }'
        after = 'expect(instance).to receve(:should_email?) { true }'
        expect(autocorrect_source(before)).to eq(after)
      end
    end
  end
end