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

        def_node_matcher :create_table, <<~PATTERN
          (send nil? :create_table ...)
        PATTERN

        def on_send(node)
          check_column_migration(node)
          check_table_migration(node)
        end

        def get_column_type(node, column_type_offset)
          return nil if node.nil?

          if node.respond_to?(:children)
            node = node.children[column_type_offset]
            if node.respond_to?(:children)
              node.children.first
            else
              node
            end
          else
            node[column_type_offset].children.first
          end
        end

        def is_integer_column(node, column_type_offset)
          get_column_type(node, column_type_offset) == :integer
        end

        def get_column_name(node, column_name_offset)
          return nil if node.nil?

          if node.respond_to?(:children)
            node = node.children[column_name_offset]
            if node.respond_to?(:children)
              node.children.first.to_s
            else
              node
            end
          else
            node = node[column_name_offset]
            if node.respond_to?(:children)
              node.children.first.to_s
            else
              node.to_s
            end
          end
        end

        def is_foreign_id_column(node, column_name_offset)
          column_name = get_column_name(node, column_name_offset)
          return false unless column_name
          column_name.match(/.*_id/)
        end

        def is_primary_id_column(node, column_name_offset)
          get_column_name(node, column_name_offset) == "id"
        end

        def check_column_migration(node)
          return unless change_column(node) || add_column(node)

          column_type_offset = 4
          column_name_offset = 3

          if is_foreign_id_column(node, column_name_offset) && is_integer_column(node, column_type_offset)
            add_offense(node, message: FK_VIOLATION_MSG)
          elsif is_primary_id_column(node, column_name_offset) && is_integer_column(node, column_type_offset)
            add_offense(node, message: PK_VIOLATION_MSG)
          end
        end

        def check_table_migration(node)
          return unless create_table(node)

          column_type_offset = 1
          column_name_offset = 2

          def get_column_definitions(node)
            block_node = node.block_node
            if block_node.children[2].is_a? RuboCop::AST::SendNode
              return [block_node.children[2].children]
            elsif block_node.is_a? RuboCop::AST::Node
              return block_node.children[2].children
            end
            []
          end

          def get_table_id_type(node)
            begin
              id_type = node.children[3].children[0].children
              if id_type[0].children[0] == :id
                return id_type[1].children[0]
              end
            rescue
            end
            nil
          end

          table_id_type = get_table_id_type(node)
          unless table_id_type.nil?
            if table_id_type == :integer
              add_offense(node, message: PK_VIOLATION_MSG)
            end
          end

          get_column_definitions(node).each do |column|
            if is_foreign_id_column(column, column_name_offset) && is_integer_column(column, column_type_offset)
              add_offense(column, message: FK_VIOLATION_MSG)
            elsif is_primary_id_column(column, column_name_offset) && is_integer_column(column, column_type_offset)
              add_offense(column, message: PK_VIOLATION_MSG)
            end
          end
        end
      end
    end
  end
end
