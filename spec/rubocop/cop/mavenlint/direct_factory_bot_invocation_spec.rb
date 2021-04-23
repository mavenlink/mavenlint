require 'rubocop/cop/mavenlint/direct_factory_bot_invocation'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::DirectFactoryBotInvocation do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when FactoryBot.create is used' do
    expect_offense(<<~RUBY)
      FactoryBot.create(:maven_participation, foo: 'bar')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Direct calls to FactoryBot should be replaced with Mavenlink::ModelFactories calls
    RUBY
  end

  it 'registers an offense when FactoryBot.build is used' do
    expect_offense(<<~RUBY)
      FactoryBot.build(:maven_participation, foo: 'bar')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Direct calls to FactoryBot should be replaced with Mavenlink::ModelFactories calls
    RUBY
  end
end
