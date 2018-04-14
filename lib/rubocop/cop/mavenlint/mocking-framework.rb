require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      class MockingFramework < RuboCop::Cop::Cop
        MSG = 'Use rspec-mocks'.freeze

        def_node_matcher :double_r?, <<~PATTERN
          (send
            (send nil? :stub
              (send nil? $_stubbed))
            $...)
        PATTERN

        def on_send(node)
          return unless double_r?(node)
          add_offense(node, message: MSG)
        end

        def autocorrect(node)
          lambda do |corrector|
            if matches = double_r?(node)
              corrector.replace(node.source_range, replacement(*matches))
            end
          end
        end

        private

        def replacement(stubbed, method_with_args)
          if method_with_args.count == 1
            "allow(#{stubbed}).to receve(:#{method_with_args.first})"
          else
            args = method_with_args.drop(1).map(&:source)
            "allow(#{stubbed}).to receve(:#{method_with_args.first}).with(#{args.join(', ')})"
          end
        end
      end
    end
  end
end
