require "test_helper"

class ToysControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:danray)
    @non_admin = users(:genie)
    
    @flash = toys(:flash)
  end

  test "should get index" do
    get toys_url
    assert_response :success
  end

  test "should redirect show when not logged in" do
    get toy_path(@flash)
    assert_redirected_to login_url
  end

  # test "should redirect create  when user not an admin" do 
  #   log_in_as @non_admin
  #   assert_no_difference 'Toy.count' do
  #     post toys_path, params: { toy: { name: "flash", description: "fastest man alive", user_id: @non_admin.id}}
  #   end
  #   assert_redirected_to root_url
  # end

  test "should redirect edit when user not an admin" do 
    log_in_as @non_admin
    assert_no_difference 'Toy.count' do
      patch toy_path(@flash), params: { toy: { name: "flash", description: "fastest man alive", user_id: @non_admin.id}}
    end
    assert_redirected_to root_url
  end

  test "should redirect delete when user not an admin" do
    log_in_as @non_admin
    assert_no_difference 'Toy.count' do
      delete toy_path(@flash)
    end
    assert_redirected_to root_url
  end

end