require "test_helper"

class WlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wlan = wlans(:one)
  end

  test "should get index" do
    get wlans_url
    assert_response :success
  end

  test "should get new" do
    get new_wlan_url
    assert_response :success
  end

  test "should create wlan" do
    assert_difference("Wlan.count") do
      post wlans_url, params: { wlan: { a: @wlan.a, autochannel: @wlan.autochannel, channel: @wlan.channel, client_id: @wlan.client_id, dateadded: @wlan.dateadded, description: @wlan.description, g: @wlan.g, lastseen: @wlan.lastseen, mac: @wlan.mac, name: @wlan.name, phy: @wlan.phy, status: @wlan.status, txpower: @wlan.txpower, wlan: @wlan.wlan } }
    end

    assert_redirected_to wlan_url(Wlan.last)
  end

  test "should show wlan" do
    get wlan_url(@wlan)
    assert_response :success
  end

  test "should get edit" do
    get edit_wlan_url(@wlan)
    assert_response :success
  end

  test "should update wlan" do
    patch wlan_url(@wlan), params: { wlan: { a: @wlan.a, autochannel: @wlan.autochannel, channel: @wlan.channel, client_id: @wlan.client_id, dateadded: @wlan.dateadded, description: @wlan.description, g: @wlan.g, lastseen: @wlan.lastseen, mac: @wlan.mac, name: @wlan.name, phy: @wlan.phy, status: @wlan.status, txpower: @wlan.txpower, wlan: @wlan.wlan } }
    assert_redirected_to wlan_url(@wlan)
  end

  test "should destroy wlan" do
    assert_difference("Wlan.count", -1) do
      delete wlan_url(@wlan)
    end

    assert_redirected_to wlans_url
  end
end
