require "test_helper"

class Mutations::DeleteToyTest < ActiveSupport::TestCase
  def perform(user: nil, toy: nil)
    Mutations::DeleteToy.new(object: nil, field: nil, context: { current_user: user }).resolve(id: toy.id)
  end

  test "delete a toy" do
    user = create_user
    toy = create_toy(user: user)

    assert_difference "Toy.count", -1 do
      perform(user: user, toy: toy)
    end

  end

  private

  def create_user
    User.create!(
      name: "Test User",
      email: "test@example.com",
      password: '[ommited]',
    )
  end

  def create_toy(user:)
    Toy.create!(
      name: "Teddy Bear",
      description: "description",
      images: [],
      user: user
    )
  end
end