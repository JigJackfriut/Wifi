require "test_helper"

class WificlientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wificlient = wificlients(:one)
  end

  test "should get index" do
    get wificlients_url
    assert_response :success
  end

  test "should get new" do
    get new_wificlient_url
    assert_response :success
  end

  test "should create wificlient" do
    assert_difference("Wificlient.count") do
      post wificlients_url, params: { wificlient: { clientversion: @wificlient.clientversion, confighash: @wificlient.confighash, dateadded: @wificlient.dateadded, enabled: @wificlient.enabled, hwmodel: @wificlient.hwmodel, ipaddress: @wificlient.ipaddress, lastseen: @wificlient.lastseen, location: @wificlient.location, name: @wificlient.name, note: @wificlient.note, osversion: @wificlient.osversion, ownerid: @wificlient.ownerid, pollrate: @wificlient.pollrate, status: @wificlient.status } }
    end

    assert_redirected_to wificlient_url(Wificlient.last)
  end

  test "should show wificlient" do
    get wificlient_url(@wificlient)
    assert_response :success
  end

  test "should get edit" do
    get edit_wificlient_url(@wificlient)
    assert_response :success
  end

  test "should update wificlient" do
    patch wificlient_url(@wificlient), params: { wificlient: { clientversion: @wificlient.clientversion, confighash: @wificlient.confighash, dateadded: @wificlient.dateadded, enabled: @wificlient.enabled, hwmodel: @wificlient.hwmodel, ipaddress: @wificlient.ipaddress, lastseen: @wificlient.lastseen, location: @wificlient.location, name: @wificlient.name, note: @wificlient.note, osversion: @wificlient.osversion, ownerid: @wificlient.ownerid, pollrate: @wificlient.pollrate, status: @wificlient.status } }
    assert_redirected_to wificlient_url(@wificlient)
  end

  test "should destroy wificlient" do
    assert_difference("Wificlient.count", -1) do
      delete wificlient_url(@wificlient)
    end

    assert_redirected_to wificlients_url
  end
end
