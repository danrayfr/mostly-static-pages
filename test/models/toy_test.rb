require "test_helper"

class ToyTest < ActiveSupport::TestCase
  def setup
    @user = users(:danray)
    @toy = @user.toys.build(name: "Flash", description: "the fastest man alive.")
  end

  test "should be valid" do 
    assert @toy.valid?
  end

  test "name should be present" do
    @toy.name = nil
    assert_not @toy.valid?
  end

  test "description should be at most 255 characters" do
    @toy.description = "a" * 256
    assert_not @toy.valid?
  end

end
