# frozen_string_literal: true

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
        MSG = 'Do not add an association to account with dependent destroy. The destroy should go on the other side of the association. If you are sure the dependent action should be on this side of the association use dependent: :nullify See https://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-dependent'

        ASSOCIATIONS = %i[belongs_to has_many has_one has_and_belongs_to_many].freeze
        DEPENDENT_DESCTRUCTIVES = %i[destroy destroy_async delete delete_all].freeze
        PROTECTED_MODELS = %i[account accounts].freeze

        def_node_matcher :dangerous_direct_account_association?, <<~PATTERN
          (send nil? #association?
            (sym #protected_model?)
            (hash
              <(pair
                (sym :dependent)#{' '}
                (sym #destructive?))#{' '}
              ...>
            ))
        PATTERN

        def_node_matcher :dangerous_indirect_account_association?, <<~PATTERN
          (send nil? #association?
            (sym _)
            (hash
              <(pair
                (sym :dependent)
                (sym #destructive?))
              (pair
                (sym :class_name)
                (str "Account"))
              ...>
            ))
        PATTERN

        def on_send(node)
          has_direct_danger = dangerous_direct_account_association?(node)
          has_indirect_danger = dangerous_indirect_account_association?(node)
          return unless has_direct_danger || has_indirect_danger

          add_offense(node, message: MSG)
        end

        def association?(symbol)
          ASSOCIATIONS.include?(symbol)
        end

        def destructive?(symbol)
          DEPENDENT_DESCTRUCTIVES.include?(symbol)
        end

        def protected_model?(symbol)
          PROTECTED_MODELS.include?(symbol)
        end
      end
    end
  end
end
