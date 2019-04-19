require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      # Enforce controllers inheriting from ApplicationController instead of ActionController::Base
      #
      # For example
      #
      #   class SomeController < ActionController::Base
      #   end
      #
      # should be
      #
      #   class SomeController < ApplicationController
      #   end
      #
      class UseApplicationController < RuboCop::Cop::Cop
        MSG = 'Controllers should subclass `ApplicationController`.'.freeze
        SUPERCLASS = 'ApplicationController'.freeze
        BASE_PATTERN = '(const (const nil? :ActionController) :Base)'.freeze

        include RuboCop::Cop::EnforceSuperclass
      end
    end
  end
end
