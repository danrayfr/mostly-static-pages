require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:danray)
  end
  test "should get index" do
    log_in_as @admin_user
    get dashboard_url
    assert_response :success
  end
end
