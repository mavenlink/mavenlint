require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      # Enforce models inheriting from ApplicationRecord instead of ActiveRecord::Base
      #
      # For example
      #
      #   class SomeModel < ActiveRecord::Base
      #   end
      #
      # should be
      #
      #   class SomeModel < ApplicationRecord
      #   end
      #
      # Note that this cop is built in to RuboCop. However, it only runs on Rails 5, and we want
      # run it even though we're on Rails 4. Once we're on Rails 5, however, we should be able to
      # remove this custom cop and enable the built-in one.
      # @see https://github.com/bbatsov/rubocop/blob/10a7041d23bcd579821b378dd351aeead7c3f082/lib/rubocop/cop/rails/application_record.rb
      #
      class UseApplicationRecord < RuboCop::Cop::Cop
        MSG = 'Models should subclass `ApplicationRecord`.'.freeze
        SUPERCLASS = 'ApplicationRecord'.freeze
        BASE_PATTERN = '(const (const nil? :ActiveRecord) :Base)'.freeze

        include RuboCop::Cop::EnforceSuperclass
      end
    end
  end
end
