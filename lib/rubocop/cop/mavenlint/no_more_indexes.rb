# frozen_string_literal: true
require 'rubocop'
module RuboCop
  module Cop
    module Mavenlint
      class NoMoreIndexes < RuboCop::Cop::Cop
        INDEX_VIOLATION_MSG = "Indexes are temporarily off the menu: please consult devchat if you see this".freeze

        def_node_matcher :add_index, <<~PATTERN
          (send nil? :add_index ...)
        PATTERN

        def on_send(node)
          return unless add_index(node)
          add_offense(node, message: INDEX_VIOLATION_MSG)
        end
      end
    end
  end
end