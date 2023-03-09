# frozen_string_literal: true

module Types
  class ToyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :images, [String], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :posted_by, UserType, null: true, method: :user
  end
end
