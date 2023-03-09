require "test_helper"

class Mutations::CreateToyTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    Mutations::CreateToy.new(object: nil, field: nil, context: { current_user: user }).resolve(**args)
  end

  test 'create a new toy' do
    user = create_user
    toy = perform(
      name: 'Teddy Bear',
      description: 'description',
      images: [],
      user: user
    )

  assert toy[:toy].persisted?
  assert_equal toy[:toy].name, 'Teddy Bear'
  assert_equal toy[:toy].description.body.to_s, "<div class=\"trix-content\">\n  description\n</div>\n"
  assert toy[:toy].images.empty?
  assert_equal toy[:toy].user.email, 'test@example.com'

  end

  private

  def create_user
    User.create!(
      name: "Test User",
      email: "test@example.com",
      password: '[ommited]',
    )
  end
end