require "test_helper"

class UserzonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @userzone = userzones(:one)
  end

  test "should get index" do
    get userzones_url
    assert_response :success
  end

  test "should get new" do
    get new_userzone_url
    assert_response :success
  end

  test "should create userzone" do
    assert_difference("Userzone.count") do
      post userzones_url, params: { userzone: { pmk: @userzone.pmk, user_id: @userzone.user_id, zone_id: @userzone.zone_id } }
    end

    assert_redirected_to userzone_url(Userzone.last)
  end

  test "should show userzone" do
    get userzone_url(@userzone)
    assert_response :success
  end

  test "should get edit" do
    get edit_userzone_url(@userzone)
    assert_response :success
  end

  test "should update userzone" do
    patch userzone_url(@userzone), params: { userzone: { pmk: @userzone.pmk, user_id: @userzone.user_id, zone_id: @userzone.zone_id } }
    assert_redirected_to userzone_url(@userzone)
  end

  test "should destroy userzone" do
    assert_difference("Userzone.count", -1) do
      delete userzone_url(@userzone)
    end

    assert_redirected_to userzones_url
  end
end
