require "test_helper"

class WlanclientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wlanclient = wlanclients(:one)
  end

  test "should get index" do
    get wlanclients_url
    assert_response :success
  end

  test "should get new" do
    get new_wlanclient_url
    assert_response :success
  end

  test "should create wlanclient" do
    assert_difference("Wlanclient.count") do
      post wlanclients_url, params: { wlanclient: { clientversion: @wlanclient.clientversion, confighash: @wlanclient.confighash, dateadded: @wlanclient.dateadded, hwmodel: @wlanclient.hwmodel, ipaddress: @wlanclient.ipaddress, lastseen: @wlanclient.lastseen, location: @wlanclient.location, name: @wlanclient.name, note: @wlanclient.note, osversion: @wlanclient.osversion, ownerid: @wlanclient.ownerid, pollrate: @wlanclient.pollrate, status: @wlanclient.status } }
    end

    assert_redirected_to wlanclient_url(Wlanclient.last)
  end

  test "should show wlanclient" do
    get wlanclient_url(@wlanclient)
    assert_response :success
  end

  test "should get edit" do
    get edit_wlanclient_url(@wlanclient)
    assert_response :success
  end

  test "should update wlanclient" do
    patch wlanclient_url(@wlanclient), params: { wlanclient: { clientversion: @wlanclient.clientversion, confighash: @wlanclient.confighash, dateadded: @wlanclient.dateadded, hwmodel: @wlanclient.hwmodel, ipaddress: @wlanclient.ipaddress, lastseen: @wlanclient.lastseen, location: @wlanclient.location, name: @wlanclient.name, note: @wlanclient.note, osversion: @wlanclient.osversion, ownerid: @wlanclient.ownerid, pollrate: @wlanclient.pollrate, status: @wlanclient.status } }
    assert_redirected_to wlanclient_url(@wlanclient)
  end

  test "should destroy wlanclient" do
    assert_difference("Wlanclient.count", -1) do
      delete wlanclient_url(@wlanclient)
    end

    assert_redirected_to wlanclients_url
  end
end
