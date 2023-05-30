# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      # Prevents use of slow capybara matchers
      class RequireSlowHelpers < RuboCop::Cop::Cop
        MSG = 'Specs in the unit directory should not require rails_helper or spec_helper'
        SLOW_HELPERS = %w[spec_helper rails_helper].freeze

        def_node_matcher :requires_slow_helpers, <<~PATTERN
          (send nil? :require
            (str #slow_helper?))
        PATTERN

        def on_send(node)
          return unless requires_slow_helpers(node)

          add_offense(node, message: MSG)
        end

        def slow_helper?(helper)
          SLOW_HELPERS.include?(helper)
        end
      end
    end
  end
end
