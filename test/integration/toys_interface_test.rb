require "test_helper"

class ToysInterfaceTest < ActionDispatch::IntegrationTest
  def setup
  @user = users(:danray)
  @non_admin = users(:genie)
  @toy = toys(:flash)
  end

  test "Toys Interface index" do
    get toys_path
    assert_select 'h1', text: 'Toys'
    assert_match @user.toys.name, response.body
  end

  test "Toys Interface index with admin user" do
    log_in_as @user
    get toys_path
    assert_select 'h1', text: 'Toys'
    assert_match @user.toys.name, response.body
    assert_select 'a', 'Create new'
  end

  test "Toys Interface show" do 
    log_in_as @user
    get toy_path(@toy)
    assert_match @toy.name, response.body
    assert_match @toy.description, response.body
    assert_select 'a', text: 'Delete'
  end

   test "Toys Interface show for non admin user" do 
    log_in_as @non_admin
    get toy_path(@toy)
    assert_match @toy.name, response.body
    assert_match @toy.description, response.body
    assert_select 'a', text: 'Edit Toy', count: 0
    assert_select 'a', text: 'Delete', count: 0
  end

  test "Toys interface create" do
    log_in_as @user
    get new_toy_path
    assert_match 'New Toy', response.body
    assert_difference 'Toy.count', 1 do
      post toys_path, params: { toy: { name: "flash", description: "fastest man alive", user_id: @non_admin.id}}
    end
    assert_redirected_to toys_path
    assert_not flash.empty?
  end

  test "Toys interface edit" do
    log_in_as @user

    # get edit_toy_path(@toy)
    # assert_no_difference 'Toy.count' do
    #   patch toy_path(@toy), params: { toy: { name: "flash", description: "fastest man alive", user_id: @non_admin.id}}
    # end
    # assert_redirected_to toy_path(@toy)
    # assert_not flash.empty?
  end

  test "Toys interface delete" do
    log_in_as @user
    get toy_path(@toy)
    assert_select 'a', 'Delete'
    assert_difference 'Toy.count', -1 do
      delete toy_path(@toy)
    end
    follow_redirect!
    assert_not flash.empty?
  end
end
