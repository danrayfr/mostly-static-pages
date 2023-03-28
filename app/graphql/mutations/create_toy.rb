require "jwt"
require "pry"
module Mutations
  class Mutations::CreateToy < Mutations::BaseMutation
    # Require authentication to create a toy
    argument :name, String, required: true
    argument :description, String, required: true
    argument :images, [String], required: false
    # type Types::ToyType

    field :toy, Types::ToyType, null: true
    field :errors, [String], null: false

    def resolve(name:, description:, images:)
      errors = []
      user = context[:current_user]
      # user = current_user
      
      unless user
        errors << "User must be authenticated to create a toy"
        return { toy: nil, errors: errors }
      end
      
      # binding.pry
      
      toy = user.toys.build(name: name, description: description, images: images)
      
      if toy.save
        { toy: toy, errors: [] }
      else
        { toy: nil, errors: toy.errors.full_messages }
      end
      
    end

    # def current_user 
    #   secret_key = Rails.application.credentials.secret_key_base
    #   puts "Secret key: #{secret_key}"
    #   token = get_bearer_token
    #   puts "current user token from headers: #{token}"

    #   return nil unless token.present?

    #   begin
    #     secret_key = Rails.application.credentials.secret_key_base
    #     decoded_token = JWT.decode(token, secret_key, true, algorithm: "HS256")
    #     user_id = decoded_token.first["user_id"]
    #     User.find_by(id: user_id)
    #   rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
    #     nil
    #   end
    # end

    # def get_bearer_token
    #   bearer = context[:request].headers['Authorization'] || context[:request].headers['authorization']
    #   if bearer.present?
    #     token = bearer.gsub('Bearer ', '').strip
    #     token = token.undump
    #     puts "Token from headers: #{token}"
    #     token
    #   else 
    #     nil
    #   end
    # end
    #

  end
end