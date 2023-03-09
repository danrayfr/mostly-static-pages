module Mutations
  class UpdateToy < Mutations::BaseMutation
    null true
    argument :id, ID, required: true
    argument :name, String, required: true
    argument :description, String, required: true
    argument :images, [String], required: false

    field :toy, Types::ToyType, null: false
    field :errors, [String], null: false

    def resolve(id:, name:, description:, images:)
      user = context[:current_user]

      if user.nil?
        raise GraphQL::ExecutionError,
              "You need to authenticate to perform this action"
      end

      toy = Toy.find(id)
      correct_user = toy.user_id == user.id
      
      if correct_user
        if toy.update(name: name, description: description, images: images)
          { toy: toy, errors: [] }
        else
          { toy: nil, errors: toy.errors.full_messages }
        end
      else
        raise GraphQL::ExecutionError, "You're not the owner of this toy listing."
      end
      
    end
    
  end
end
