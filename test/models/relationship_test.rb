require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @user = users(:danray)
    @other_user = users(:genie)

    @relationship = Relationship.new(follower_id: @user.id, followed_id: @other_user.id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
