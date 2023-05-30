# frozen_string_literal: true

require 'rubocop/cop/mavenlint/use_fast_capybara_matchers'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::UseFastCapybaraMatchers do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when "to_not have_*" is used' do
    expect_offense(<<~RUBY)
      expect(page).to_not have_text('Hello')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use a `to have_no_*` selector. See https://github.com/mavenlink/welcome/wiki/Lint-Errors#usefastcapybaramatchers
    RUBY
  end

  it 'registers an offense when "to_not have_*" is used' do
    expect_offense(<<~RUBY)
      expect(page.find('.greeting')).to_not have_text('Hello')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use a `to have_no_*` selector. See https://github.com/mavenlink/welcome/wiki/Lint-Errors#usefastcapybaramatchers
    RUBY
  end

  it 'registers an offense when "to_not have_*" is used' do
    expect_offense(<<~RUBY)
      expect(page).to_not have_css('.wat')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use a `to have_no_*` selector. See https://github.com/mavenlink/welcome/wiki/Lint-Errors#usefastcapybaramatchers
    RUBY
  end

  it 'passes when "to have_no_*" is used' do
    expect_no_offenses(<<~RUBY)
      expect(page).to have_no_text('Hello')
    RUBY

    expect_no_offenses(<<~RUBY)
      expect(page).to have_no_css('.wat')
    RUBY
  end

  it 'passes when "to have_*" is used' do
    expect_no_offenses(<<~RUBY)
      expect(page).to have_text('Hello')
    RUBY

    expect_no_offenses(<<~RUBY)
      expect(page).to have_css('.wat')
    RUBY
  end

  it 'passes when a non-Capybara matcher is used' do
    expect_no_offenses(<<~RUBY)
      expect(page).to_not have_a_foobar
    RUBY
  end
end
