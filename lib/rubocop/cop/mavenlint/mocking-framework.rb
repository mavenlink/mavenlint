require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      class MockingFramework < RuboCop::Cop::Cop
        MSG = 'Use rspec-mocks'.freeze

        def_node_matcher :double_r?, <<~PATTERN
          (send
            (send nil? :stub
              (send nil? $_stubbed)) $_method)
        PATTERN

        def_node_matcher :in_block?, <<~PATTERN
          (block
            #double_r?
            _blockargs
            _blockbody)
        PATTERN

        def on_block(node)
          return unless in_block?(node)
          add_offense(node, message: MSG)
        end
      end
    end
  end
end
