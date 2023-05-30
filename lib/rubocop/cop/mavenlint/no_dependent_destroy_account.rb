require 'rubocop'

module RuboCop
  module Cop
    module Mavenlint
      # Identify usages of active record associations to account with dependent: :destroy or dependent: :delete
      #
      # For example
      #
      #   class SomeModel
      #     belongs_to :account, dependent: :destroy
      #   end
      #
      # Allowing deletion of account through active record associations can cause cascading data deletions. Account
      # is a root object and shouldn't be deleted via active record associations
      class NoDependentDestroyAccount < RuboCop::Cop::Cop
        MSG = "Do not add an association to account with dependent destroy. The destroy should go on the other side of the association. If you are sure the dependent action should be on this side of the association use dependent: :nullify See https://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-dependent"


        ASSOCIATIONS = %i(belongs_to has_may has_one has_and_belongs_to_many)

        def_node_matcher :dangerous_account_association?, <<~PATTERN
          (send nil? :belongs_to
            (sym :account)
            (hash
              (pair
                (sym :dependent)
                (sym :destroy))))
        PATTERN

        def on_send(node)
          return unless dangerous_account_association?(node)
          add_offense(node, message: MSG)
        end

        private

        def association?(node)
          node.command?(:belongs_to)
        end

        def associating_account?(node)
          node.first_argument.source == ":account"
        end

        def unsafe_options?(node)
          node.arguments.any? do |arg|
            arg.type == :hash
          end
        end
      end
    end
  end
end
