require 'rubocop/cop/mavenlint/no_dependent_destroy_account'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::NoDependentDestroyAccount do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when belongs_to :account has dependent: :destroy option' do
    expect_offense(<<~RUBY)
      belongs_to :account, inverse_of: :foo, dependent: :destroy, autosave: true
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not add an association to account with dependent destroy. The destroy should go on the other side of the association. If you are sure the dependent action should be on this side of the association use dependent: :nullify See https://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-dependent
    RUBY
  end
end
