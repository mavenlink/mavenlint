# frozen_string_literal: true

require 'rubocop/cop/mavenlint/use_application_record'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::UseApplicationRecord do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense a model directly inherits from ActiveRecord::Base' do
    expect_offense(<<~RUBY)
      class User < ActiveRecord::Base; end
                   ^^^^^^^^^^^^^^^^^^ Models should subclass `ApplicationRecord`.
    RUBY
  end

  it 'passes when a model inherits from ApplicationRecord' do
    expect_no_offenses(<<~RUBY)
      class User < ApplicationRecord; end
    RUBY
  end

  it 'passes when a model inherits from an other class' do
    expect_no_offenses(<<~RUBY)
      class User < SuperUserSuperClass; end
    RUBY
  end
end
