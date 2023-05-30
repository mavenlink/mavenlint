require 'rubocop/cop/mavenlint/no_dependent_destroy_account'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::NoDependentDestroyAccount do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  described_class::ASSOCIATIONS.each do |association|
    described_class::DEPENDENT_DESCTRUCTIVES.each do |destructive|
      it "registers an offense when #{association} :account has dependent: :#{destructive} option" do
        message = " Do not add an association to account with dependent destroy. The destroy should go on the other side of the association. If you are sure the dependent action should be on this side of the association use dependent: :nullify See https://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-dependent"
        ruby_code = "#{association} :account, inverse_of: :foo, dependent: :#{destructive}, autosave: true"

        message = message.rjust(ruby_code.length + message.length, '^')
        expect_offense(<<~RUBY)
          #{ruby_code}
          #{message}
        RUBY
      end
    end

    described_class::ASSOCIATIONS.each do |association|
      described_class::DEPENDENT_DESCTRUCTIVES.each do |destructive|
        it "registers an offense when #{association} :account has dependent: :#{destructive} option" do
          ruby_code = "#{association} :other_model, inverse_of: :foo, dependent: :#{destructive}, autosave: true"

          expect_no_offenses(ruby_code)
        end
      end
    end
  end
end
