require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      # Enforce Api controllers inheriting from ApiController instead of ActionController::Base
      #
      # For example
      #
      #   class SomeApiController < ActionController::Base
      #   end
      #
      # should be
      #
      #   class SomeApiController < ApiController
      #   end
      #
      class UseApiController < RuboCop::Cop::Cop
        MSG = 'Controllers should subclass `ApiController`.'.freeze
        SUPERCLASS = 'ApiController'.freeze
        BASE_PATTERN = '(const (const nil? :ActionController) :Base)'.freeze

        include RuboCop::Cop::EnforceSuperclass
      end
    end
  end
end
