require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      class MockingFramework < RuboCop::Cop::Cop
        MSG = 'Use rspec-mocks'.freeze
        RR_PATTERN = (<<~PATTERN).freeze
          (send
            (send nil? :stub (send nil? $_stubbed))
            $...)
        PATTERN

        def_node_matcher :double_r?, RR_PATTERN

        def_node_matcher :in_block?, <<~PATTERN
          (block
            #{RR_PATTERN}
            $_blockargs
            ($_blockbody))
        PATTERN

        def on_block(node)
          return unless in_block?(node)
          add_offense(node, message: MSG)
        end

        def autocorrect(node)
          lambda do |corrector|
            if matches = in_block?(node)
              corrector.replace(node.source_range, replacement(matches))
            end
          end
        end

        private

        def replacement(matches)
          stubbed, method, blockargs, blockbody = matches
          if method.count == 1
            "allow(#{stubbed}).to receve(:#{method.first}) { #{blockbody} }"
          else
            "allow(#{stubbed}).to receve(:#{method.first}).with(#{method.drop(1).map(&:source).join(', ')}) { #{blockbody} }"
          end
        end
      end
    end
  end
end
