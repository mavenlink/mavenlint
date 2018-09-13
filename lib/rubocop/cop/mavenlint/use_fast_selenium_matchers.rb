require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      # Identify usages of `to_not` with a Capybara matcher, which will be really slow.
      #
      # For example
      #
      #   expect(page).to_not have_text('Hi')
      #
      # Writing an assertion this way will first try to find the text 'Hi'. If not present,
      # Capybara will wait for the full timeout (often 30 seconds) before then inverting with
      # `to_not` and passing.
      #
      # Instead, we should do something like:
      #
      #   expect(page).to have_no_text('Hi')
      #
      # Which will pass as soon as the text is not detected without any timeout.
      class UseFastSeleniumMatchers < RuboCop::Cop::Cop
        MSG = 'Use a `to have_no_*` selector'.freeze

        def_node_matcher :slow_capybara_matcher?, <<~PATTERN
          (send
            (send nil? :expect _)
            :to_not
            (send nil? #have? ...))
        PATTERN

        def on_send(node)
          return unless slow_capybara_matcher?(node)

          add_offense(node)
        end

        private

        def have?(string)
          string.to_s.start_with?('have_')
        end
      end
    end
  end
end
