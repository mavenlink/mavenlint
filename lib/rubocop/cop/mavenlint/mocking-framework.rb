require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      class MockingFramework < RuboCop::Cop::Cop
        MSG = 'Use rspec-mocks'.freeze

        def_node_matcher :double_r?, <<~PATTERN
          (block
            (send
              (send nil? :stub
                (send nil? :instance)) :should_email?)
            (args)
            (true))
        PATTERN

        def on_block(node)
          return unless double_r?(node)
          add_offense(node, message: MSG)
        end
      end
    end
  end
end
