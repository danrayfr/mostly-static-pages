require "test_helper"

class Mutations::CreateToyTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    Mutations::CreateToy.new(object: nil, field: nil, context: {}).resolve(**args)
  end

  test "create a new toy" do
    toy = perform(
      name: 'Toy Story Action Figure',
      description: 'description', 
      images: [],
      user: context[:current_user]
    )

    assert toy.persisted?
    assert_equal toy.description, 'description'
    assert_equal toy.name'oy Story Action Figure'
    
  end
end