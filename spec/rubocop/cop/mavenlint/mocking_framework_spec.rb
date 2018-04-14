require 'rubocop/cop/mavenlint/mocking-framework'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::MockingFramework do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  describe 'stubs' do
    describe 'simple block with no arguments' do
      it 'detects them' do
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

      it 'autocorrects' do
        before = 'stub(user).is_administrator? { false }'
        after = 'allow(user).to receve(:is_administrator?) { false }'
        expect(autocorrect_source(before)).to eq(after)
      end
    end

    describe 'simple block with arguments' do
      it 'detects them' do
        expect_offense(<<~RUBY)
          stub(workspace).is_participant?(user) { true }
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use rspec-mocks
        RUBY
      end

      it 'passes when rspec-mocks is used' do
        expect_no_offenses(<<~RUBY)
          allow(workspace).to receve(:is_participant?).with(user) { true }
        RUBY
      end

      it 'autocorrects' do
        before = 'stub(workspace).is_participant?(user) { true }'
        after = 'allow(workspace).to receve(:is_participant?).with(user) { true }'
        expect(autocorrect_source(before)).to eq(after)
      end
    end
  end
end
