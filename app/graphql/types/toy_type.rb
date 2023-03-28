# frozen_string_literal: true

module Types
  class ToyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :images_url, [String], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :posted_by, UserType, null: true, method: :user

    # def description
    #   ActionController::Base.helpers.strip_tags(object.description.to_plain_text)
    # end

    def images_url
      object.images.map do |image|
        Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
      end
    end

  end
end
