require 'rubocop/cop/mavenlint/bigint_for_migration_keys'
require 'spec_helper'

RSpec.describe RuboCop::Cop::Mavenlint::BigIntForMigrationKeys do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  context 'change_column' do
    context 'foreign key' do
      it 'registers an offense when a *_id column is changed to integer' do
        expect_offense(<<~RUBY)
          def up
            change_column :preferences, :subject_id, :integer
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Foreign keys must be of type BIGINT
          end
        RUBY
      end

      it 'passes when *_id column changed to bigint' do
        expect_no_offenses(<<~RUBY)
          def up
            change_column :preferences, :subject_id, :bigint
          end
        RUBY
      end
    end

    context 'primary key' do
      it 'registers an offense when an :id column is changed to integer' do
        expect_offense(<<~RUBY)
          def up
            change_column :preferences, :id, :integer
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Primary keys must be of type BIGINT
          end
        RUBY
      end

      it 'passes when an :id column is changed to bigint' do
        expect_no_offenses(<<~RUBY)
          def up
            change_column :preferences, :id, :bigint
          end
        RUBY
      end
    end
  end

  context 'add_column' do
    context 'foreign key' do
      it 'registers an offense when a *_id column is added as integer' do
        expect_offense(<<~RUBY)
          def up
            add_column :preferences, :subject_id, :integer
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Foreign keys must be of type BIGINT
          end
        RUBY
      end

      it 'passes when *_id column added as bigint' do
        expect_no_offenses(<<~RUBY)
          def up
            add_column :preferences, :subject_id, :bigint
          end
        RUBY
      end
    end

    context 'primary key' do
      it 'registers an offense when an id column is added as integer' do
        expect_offense(<<~RUBY)
          def up
            add_column :preferences, :id, :integer
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Primary keys must be of type BIGINT
          end
        RUBY
      end

      it 'passes when :id column added as bigint' do
        expect_no_offenses(<<~RUBY)
          def up
            add_column :preferences, :id, :bigint
          end
        RUBY
      end
    end
  end

  context 'create_table' do
    context 'foreign key' do
      it 'registers an offense when a *_id column is added as integer' do
        expect_offense(<<~RUBY)
          def change
            create_table :new_account_invitations do |t|
              t.integer :inviter_id, null: false
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Foreign keys must be of type BIGINT
              t.string :email_address, null: false
              t.string :token, null: false, :limit => 36
              t.timestamps
            end
          end
        RUBY
      end
    end
  end
end
