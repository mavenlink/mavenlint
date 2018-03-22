require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      class UnsafeMassAssignment < RuboCop::Cop::Cop
        MSG  = <<~MSG
          Please don't allow mass assignment of foreign key columns, which can result in setting a
          relationship with an object that the user is not allowed to interact with.
        MSG

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
