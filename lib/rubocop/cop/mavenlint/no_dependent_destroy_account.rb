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


        ASSOCIATIONS = %i(belongs_to has_many has_one has_and_belongs_to_many)

        def_node_matcher :dangerous_account_association?, <<~PATTERN
          (send nil? #association?
            (sym :account)
            (hash
              _
              (pair
                (sym :dependent)
                (sym :destroy))
              _
            ))
        PATTERN

        def on_send(node)
          return unless dangerous_account_association?(node)
          add_offense(node, message: MSG)
        end

        def association?(symbol)
          ASSOCIATIONS.include?(symbol)
        end
      end
    end
  end
end
