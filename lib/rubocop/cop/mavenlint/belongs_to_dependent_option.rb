# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      # Identify usages of active record association `belongs_to` with the dependent option
      #
      # For example
      #
      #   class SomeModel
      #     belongs_to :workspace, dependent: :destroy
      #   end
      #
      # It is advised to put the dependent option on the other side of the association
      class BelongsToDependentOption < RuboCop::Cop::Cop
        MSG = 'Do not use the dependent option with belongs_to associations. The option should go on the other side of the association. See https://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-dependent'

        def_node_matcher :bad_belongs_to?, <<~PATTERN
          (send nil? :belongs_to
            (sym ...)
            (hash
              <(pair
                (sym :dependent)
                (sym ...))
              ...>
            ))
        PATTERN

        def on_send(node)
          return unless bad_belongs_to?(node)

          add_offense(node, message: MSG)
        end
      end
    end
  end
end

