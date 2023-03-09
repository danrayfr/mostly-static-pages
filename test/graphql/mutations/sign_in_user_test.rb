require "test_helper"

class Mutations::SignInUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::SignInUser.new(object: nil, field: nil, context: { session: {} }).resolve(**args)
  end
  

  test "success" do 
    user = create_user
    user.update(activated: true)
    user.update(activated_at: Time.now)
    
    result = perform(
      credentials: {
        email: user.email,
        password: user.password
      }
    )

    return unless user.activated?
    assert result[:token].present?
    assert_equal result[:user], user
  end

  private

  def create_user
    User.create!(
      name: 'Test User',
      email: 'email@example.com',
      password: '[omitted]',
    )
  end

end