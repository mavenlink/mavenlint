# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      # Identify usages of mass assignment with potentially 'unsafe' columns allowed.
      #
      # For example
      #
      #   class SomeModel
      #     attr_accessible :account_id
      #   end
      #
      # Allowing mass assignment of a foreign key column is dangerous for models that are created
      # or updated through a publicly accessible endpoint, because the associated model isn't
      # necessarily loaded and ran through security checks.
      class UnsafeMassAssignment < RuboCop::Cop::Cop
        MSG = 'Do not allow mass-assignment of foreign key columns. See https://github.com/mavenlink/welcome/wiki/Lint-Errors#unsafemassassignment'

        def on_send(node)
          return unless node.command?(:attr_accessible)

          add_offense(node, message: MSG) if unsafe_names?(node)
        end

        private

        def unsafe_names?(node)
          node.arguments.any? do |arg|
            arg.source.end_with?('_id')
          end
        end
      end
    end
  end
end
