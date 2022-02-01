
require 'rubocop/cop/mavenlint/no_more_indexes'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::NoMoreIndexes do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  context 'add_index' do
    it 'registers an error when a migration adds an index with a change method' do
      expect_offense(<<~RUBY)
        def change
          add_index :preferences, :subject_id
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Indexes are temporarily off the menu: please consult devchat if you see this
        end
      RUBY
    end

    it 'registers an error when a migration adds an index with an up method' do
      expect_offense(<<~RUBY)
        def up
          add_index :preferences, :subject_id
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Indexes are temporarily off the menu: please consult devchat if you see this
        end
      RUBY
    end

    it 'registers an error when a migration adds an index with an down method' do
      expect_offense(<<~RUBY)
        def up
          add_index :preferences, :subject_id
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Indexes are temporarily off the menu: please consult devchat if you see this
        end
      RUBY
    end

    it 'passes when there is no index' do
      expect_no_offenses(<<~RUBY)
          def up
            remove_index :preferences, :subject_id
          end
      RUBY
    end
  end
end
