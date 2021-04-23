require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      class DirectFactoryBotInvocation < RuboCop::Cop::Cop
        MSG = 'Direct calls to FactoryBot should be replaced with Mavenlink::ModelFactories calls'.freeze
        FACTORY_BOT_METHODS = %i(create build)

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
