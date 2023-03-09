require "test_helper"

class Mutations::SignInUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::SignInUser.new(object: nil, field: nil, context: { session: {} }).resolve(**args)
  end

  def create_user
    User.create!(
      name: "Test User",
      email: "test@example.com",
      password: '[ommited]',
    )
  end

  test "success" do 
    user = create_user
    user.activated = true

    result = perform(
      credentials: {
        email: user.email,
        password: user.password
      }
    )

    assert result[:token].present?
    assert_equal result[:user], user
  end
end