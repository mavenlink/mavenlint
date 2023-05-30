# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      # Enforce Api controllers inheriting from ApiController instead of ApplicationController
      #
      # For example
      #
      #   class SomeApiController < ApplicationController
      #   end
      #
      # should be
      #
      #   class SomeApiController < ApiController
      #   end
      #
      class UseApiController < RuboCop::Cop::Cop
        MSG = 'Api Controllers should subclass `ApiController`.'
        SUPERCLASS = 'ApiController'
        BASE_PATTERN = '(const nil? :ApplicationController)'

        include RuboCop::Cop::EnforceSuperclass
      end
    end
  end
end
