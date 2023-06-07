# frozen_string_literal: true

require 'rubocop/cop/mavenlint/belongs_to_dependent_option'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::BelongsToDependentOption do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when belongs_to is invoked with the dependent option' do
    expect_offense(<<~RUBY)
      belongs_to :workspace, inverse_of: :foo, dependent: :destroy_all, autosave: true
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use the dependent option with belongs_to associations. The option should go on the other side of the association. See https://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-dependent
    RUBY
  end

  it 'does not register an offense for other associations' do
    expect_no_offenses(<<~RUBY)
      has_one :workspace, inverse_of: :foo, dependent: :destroy, autosave: true
    RUBY
  end
end
