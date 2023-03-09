module Mutations
  class Mutations::CreateToy < Mutations::BaseMutation
    null true
    argument :name, String, required: true
    argument :description, String, required: true
    argument :images, [String], required: false

    # type Types::ToyType

    field :toy, Types::ToyType, null: false
    field :errors, [String], null: false

    def resolve(name:, description:, images:)
      user = context[:current_user]
      toy = user.toys.build(name: name, description: description, images: images)
      
      if toy.save
        { toy: toy, errors: [] }
      else
        { toy: nil, errors: toy.errors.full_messages }
      end

    end
    
  end
end