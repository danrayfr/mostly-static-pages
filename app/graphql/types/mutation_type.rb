module Types
  class MutationType < Types::BaseObject
    field :sign_in_user, mutation: Mutations::SignInUser
    field :create_user, mutation: Mutations::CreateUser
    field :create_toy, mutation: Mutations::CreateToy
    field :update_toy, mutation: Mutations::UpdateToy
    field :delete_toy, mutation: Mutations::DeleteToy
  end
end
