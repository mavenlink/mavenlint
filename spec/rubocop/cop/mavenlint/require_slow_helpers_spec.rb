require 'rubocop/cop/mavenlint/require_slow_helpers'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::RequireSlowHelpers do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when require "spec_helper" is used' do
    expect_offense(<<~RUBY)
      require "spec_helper"
      ^^^^^^^^^^^^^^^^^^^^^ Specs in the unit directory should not require rails_helper or spec_helper
    RUBY
  end

  it 'registers an offense when require "rails_helper" is used' do
    expect_offense(<<~RUBY)
      require "rails_helper"
      ^^^^^^^^^^^^^^^^^^^^^^ Specs in the unit directory should not require rails_helper or spec_helper
    RUBY
  end
end
