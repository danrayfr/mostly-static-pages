module Mutations
  class CreateToy < BaseMutation
    argument :name, String, required: true
    argument :description, String, required: true
    argument :images, [String], required: false

    type Types::ToyType

    def resolve(name:, description:, images:)
      user = context[:current_user]
      Toy.create!({ 
        name: name,
        description: description,
        images: images,
        user: user
      })
      
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")

      
      # toy = user.toys.build(name: name, description: description, images: images)
      # if toy.save
      #   return {toy: toy}
      # else
      #   GraphQL::ExecutionError.new("#{user.record.errors.full_messages.join(',')}")
      # end

    end
    
  end
end