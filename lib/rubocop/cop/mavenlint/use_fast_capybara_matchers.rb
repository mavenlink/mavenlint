# frozen_string_literal: true

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
      class UseFastCapybaraMatchers < RuboCop::Cop::Cop
        MSG = 'Use a `to have_no_*` selector. See https://github.com/mavenlink/welcome/wiki/Lint-Errors#usefastcapybaramatchers'
        CAPYBARA_MATCHERS = %i[have_button have_checked_field have_content have_css have_field have_link have_select
                               have_selector have_table have_text have_unchecked_field have_xpath].freeze

        def_node_matcher :slow_capybara_matcher?, <<~PATTERN
          (send
            (send nil? :expect _)
            :to_not
            (send nil? #capybara? ...))
        PATTERN

        def on_send(node)
          return unless slow_capybara_matcher?(node)

          add_offense(node)
        end

        private

        def capybara?(symbol)
          CAPYBARA_MATCHERS.include?(symbol)
        end
      end
    end
  end
end
