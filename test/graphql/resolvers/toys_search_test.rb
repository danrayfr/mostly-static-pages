require "test_helper"

module Resolvers
  class ToysSearchTest < ActiveSupport::TestCase
    def find(args)
      ::Resolvers::ToysSearch.call(nil, args, nil)
    end

    def create_user
      User.create(name: "Test User", email: "user@example.com", password: "password")
    end

    def create_toy(**attributes)
      Toy.create! attributes.merge(user: create_user)
    end

    test "filter option" do
      toy1 = create_toy(name: "Woody", description: "Toy story 1")
      toy2 = create_toy(name: "Buzz", description: "Toy story 1")
      toy3 = create_toy(name: "Jessy", description: "Toy story 2")
      toy4 = create_toy(name: "Lotso", description: "Toy story 3")

    result = find(
      filter: {
        name_contains: "Woody",
        OR: [{
          name_contains: "Buzz",
          OR: [{
            name_contains: "Jessy"
          }]
        }, {
          name_contains: "Buzz"
        }] 
      }
    )


    assert_equal result.map(&:name).sort, [toy1, toy2, toy3].map(&:name).sort

    end    

  end
end