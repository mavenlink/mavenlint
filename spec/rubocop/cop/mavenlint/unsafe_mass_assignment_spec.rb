require 'rubocop/cop/mavenlint/unsafe-mass-assignment'

describe RuboCop::Cop::Mavenlint::UnsafeMassAssignment do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense allowing mass assignment of foreign keys' do
    expect_offense(<<~RUBY)
      attr_accessible :story, :name, :account_id, :level
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not allow mass-assignment of foreign key columns
    RUBY
  end

  it 'does not register an offense when not allowing mass assignment of foreign keys' do
    expect_no_offenses(<<~RUBY)
      attr_accessible :story, :name, :account, :level
    RUBY
  end
end
