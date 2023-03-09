module Mutations
  class CreateUser < Mutations::BaseMutation
    null true
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :name, String, required: true
    argument :auth_provider, AuthProviderSignupData, required: false

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(name: nil, auth_provider: nil)
      user = User.new(
        name: name,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password)
      )

      if user.save
        user.send_activation_email
        {
          user: user,
          errors: [],
        }
      else
        {
          user: nil, errors: user.errors.full_messages
        }
      end
    end

  end
end