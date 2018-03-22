require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      class UnsafeMassAssignment < RuboCop::Cop::Cop
        MSG = "Don't allow mass-assignment of foreign key columns".freeze

        def on_send(node)
          return unless node.command?(:attr_accessible)

          if unsafe_names?(node)
            add_offense(node, message: MSG)
          end
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
