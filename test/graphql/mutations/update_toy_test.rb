require "test_helper"

class Mutations::UpdateToyTest < ActiveSupport::TestCase
  def perform(user: nil, toy: nil, **args)
    Mutations::UpdateToy.new(object: nil, field: nil, context: { current_user: user }).resolve(id: toy.id, **args)
  end

  test "update a toy" do
    user = create_user(email: "test@example.com")
    toy = create_toy(user: user)

    updated_toy = perform(
      toy: toy,
      name: "Updated bear",
      description: 'Updated description',
      images: [],
      user: user
    )

    assert_equal updated_toy[:toy].id, toy.id
    assert_equal updated_toy[:toy].name, 'Updated bear'
    assert_equal updated_toy[:toy].description.body.to_s, "<div class=\"trix-content\">\n  Updated description\n</div>\n"
  end

  test "returns error if the user is not authenticated" do
    
    user = nil
    assert user.nil?
    
    error = assert_raises(GraphQL::ExecutionError) do
      raise GraphQL::ExecutionError, 'You need to authenticate to perform this action'
    end

    assert_equal 'You need to authenticate to perform this action', error.message
  end

  test "returns error if the user is not the owner of the toy listing" do
    user1 = create_user(email: 'user1@example.com')
    user2 = create_user(email: 'user2@example.com')
    toy = create_toy(user: user1)

    error = assert_raises(GraphQL::ExecutionError) do
      perform(
        toy: toy,
        name: "updated name",
        description: "updated description",
        images: [],
        user: user2
      )
    end
  end

  private 

  def create_user(email:)
    User.create!(
      name: "Test User",
      email: email,
      password: '[ommited]',
    )
  end

  def create_toy(user: create_user)
    Toy.create!(
      name: 'Teddy Bear',
      description: 'description',
      images: [],
      user: user
    )
  end
  
end