require 'search_object'
require 'search_object/plugin/graphql'

module Resolvers
  class Resolvers::UsersSearch < BaseResolver
    # include SearchObject for GraphQL
    include SearchObject.module(:graphql)
  
    # scope is starting point for search
    scope { User.all }
  
    type types[Types::UserType]
  
    # inline input type definition for the advanced filter
    class UserFilter < ::Types::BaseInputObject
      argument :OR, [self], required: false
      argument :name_contains, String, required: false
      argument :email_contains, String, required: false
    end
  
    # when "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: UserFilter, with: :apply_filter
    option :first, type: GraphQL::Types::Int, with: :apply_first
    option :skip, type: GraphQL::Types::Int, with: :apply_skip
  
    # apply_filter recursively loops through "OR" branches
    def apply_filter(scope, value)
      branches = normalize_filters(value).reduce { |a, b| a.or(b) }
      scope.merge branches
    end
  
    def apply_first(scope, value)
      scope.limit(value)
    end
    
    def apply_skip(scope, value)
      scope.offset(value)
    end
  
    def normalize_filters(value, branches = [])
      scope = User.all
      scope = scope.where('name LIKE ?', "%#{value[:name_contains]}%") if value[:name_contains]
      scope = scope.where('email LIKE ?', "%#{value[:email_contains]}%") if value[:email_contains]
  
      branches << scope
  
      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?
  
      branches
    end
  end
end