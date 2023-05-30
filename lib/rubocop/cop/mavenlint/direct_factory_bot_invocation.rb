# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      # Prevents invocation of factory bot directly and instead
      # suggests user use the `create.a(:model)` pattern
      class DirectFactoryBotInvocation < RuboCop::Cop::Cop
        MSG = 'Direct calls to FactoryBot should be replaced with Mavenlink::ModelFactories calls'
        FACTORY_BOT_METHODS = %i[create build].freeze

        def_node_matcher :factory_bot_direct_usage, <<~PATTERN
          (send
            (const ... :FactoryBot) #factory_bot_method? ...)
        PATTERN

        def on_send(node)
          return unless factory_bot_direct_usage(node)

          add_offense(node, message: MSG)
        end

        def factory_bot_method?(symbol)
          FACTORY_BOT_METHODS.include?(symbol)
        end
      end
    end
  end
end
