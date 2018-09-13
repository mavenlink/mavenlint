require 'rubocop/cop/mavenlint/unsafe_mass_assignment'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::UnsafeMassAssignment do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when mass assignment of foreign keys is allowed' do
    expect_offense(<<~RUBY)
      attr_accessible :story, :name, :account_id, :level
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not allow mass-assignment of foreign key columns. See https://github.com/mavenlink/welcome/wiki/Lint-Errors#unsafemassassignment
    RUBY
  end

  it 'passes when mass assignment of foreign keys is not allowed' do
    expect_no_offenses(<<~RUBY)
      attr_accessible :story, :name, :account, :level
    RUBY
  end
end
