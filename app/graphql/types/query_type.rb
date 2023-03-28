module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    def me
      context[:current_user]
    end

    field :all_toys, [ToyType], null: false
    def all_toys
      Toy.all.includes(:user, :rich_text_description, images_attachments: :blob)
    end

    field :all_users, [UserType], null: false
    def all_users
      User.all
    end

    # Get user by id
    field :user, UserType, null: false do
      argument :id, ID, required: true
    end
    def user(id:)
      User.find(id)
    end

    # Get toy by id 
    field :toy, ToyType, null: false do 
      argument :id, ID, required: true
    end
    def toy(id:)
      Toy.find(id)
    end

    # filtered search
    field :filtered_toys, resolver: Resolvers::ToysSearch
    field :filtered_users, resolver: Resolvers::UsersSearch
  end
end
