require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get "http://138.28.72.137:3000/"
    assert_response :success
  end
end
