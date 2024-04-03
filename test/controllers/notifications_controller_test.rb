require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get send" do
    get notifications_send_url
    assert_response :success
  end
end
