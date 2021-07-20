require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      class BigIntForMigrationKeys < RuboCop::Cop::Cop
        FK_VIOLATION_MSG = "Foreign keys must be of type BIGINT".freeze
        PK_VIOLATION_MSG = "Primary keys must be of type BIGINT".freeze

        def_node_matcher :change_column, <<~PATTERN
          (send nil? :change_column ...)
        PATTERN

        def_node_matcher :add_column, <<~PATTERN
          (send nil? :add_column ...)
        PATTERN

        def on_send(node)
          return unless change_column(node) || add_column(node)

          if is_foreign_id_column(node) && is_integer_column(node)
            add_offense(node, message: FK_VIOLATION_MSG)
          elsif is_primary_id_column(node) && is_integer_column(node)
            add_offense(node, message: PK_VIOLATION_MSG)
          end
        end

        def is_integer_column(node)
          node.children[4].children.first == :integer
        end

        def is_foreign_id_column(node)
          node.children[3].children.first.to_s.match(/.*_id/)
        end

        def is_primary_id_column(node)
          node.children[3].children.first == :id
        end
      end
    end
  end
end
