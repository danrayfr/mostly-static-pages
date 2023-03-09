# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :password_digest, String, null: false
    field :remember_digest, String, null: false
    field :admin, Boolean, null: false
    field :activation_digest, String
    field :activated, Boolean, null: false
    field :toy, [ToyType], null: false
  end
end
