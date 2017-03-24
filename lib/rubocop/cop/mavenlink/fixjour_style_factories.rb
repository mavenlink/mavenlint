module RuboCop
  module Cop
    module Mavenlink
      # Avoid legacy Fixjour-style Factory invocations.
      #
      # Use the Factory wrapper methods that keep us indirectly
      # coupled to our test Factory library.
      #
      # @example
      #   # bad
      #   create_example(...)
      #
      #   # good
      #   create.a(:example, ...)
      class FixjourStyleFactories < Cop
        MSG = "Use `%s` instead of `%s`.".freeze
        MATCHER_REGEX = /^(create|new)_(.*)$/

        def on_send(node)
          return if false_positives.include?(node.method_name)
          return unless node.method_name.to_s =~ MATCHER_REGEX

          offending_factory_action = node.method_name.to_s.match(MATCHER_REGEX)[1].to_sym
          model_name = node.method_name.to_s.match(MATCHER_REGEX)[2].to_sym

          case offending_factory_action
            when :create
              proper_factory_action = :create
            when :new
              proper_factory_action = :build
          end

          add_offense(
            node,
            :expression,
            format(
              MSG,
              "#{proper_factory_action}.a(:#{model_name}, ...)",
              "#{offending_factory_action}_#{model_name}(...)"
            )
          )
        end

        private

        def false_positives
          @false_positives ||= %w[
            new_record?
            create_account_membership
          ].collect(&:to_sym)
        end
      end
    end
  end
end
