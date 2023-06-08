require "application_system_test_case"

class WlansTest < ApplicationSystemTestCase
  setup do
    @wlan = wlans(:one)
  end

  test "visiting the index" do
    visit wlans_url
    assert_selector "h1", text: "Wlans"
  end

  test "should create wlan" do
    visit wlans_url
    click_on "New wlan"

    fill_in "A", with: @wlan.a
    check "Autochannel" if @wlan.autochannel
    fill_in "Channel", with: @wlan.channel
    fill_in "Client", with: @wlan.client_id
    fill_in "Dateadded", with: @wlan.dateadded
    fill_in "Description", with: @wlan.description
    fill_in "G", with: @wlan.g
    fill_in "Lastseen", with: @wlan.lastseen
    fill_in "Mac", with: @wlan.mac
    fill_in "Name", with: @wlan.name
    fill_in "Phy", with: @wlan.phy
    fill_in "Status", with: @wlan.status
    fill_in "Txpower", with: @wlan.txpower
    fill_in "Wlan", with: @wlan.wlan
    click_on "Create Wlan"

    assert_text "Wlan was successfully created"
    click_on "Back"
  end

  test "should update Wlan" do
    visit wlan_url(@wlan)
    click_on "Edit this wlan", match: :first

    fill_in "A", with: @wlan.a
    check "Autochannel" if @wlan.autochannel
    fill_in "Channel", with: @wlan.channel
    fill_in "Client", with: @wlan.client_id
    fill_in "Dateadded", with: @wlan.dateadded
    fill_in "Description", with: @wlan.description
    fill_in "G", with: @wlan.g
    fill_in "Lastseen", with: @wlan.lastseen
    fill_in "Mac", with: @wlan.mac
    fill_in "Name", with: @wlan.name
    fill_in "Phy", with: @wlan.phy
    fill_in "Status", with: @wlan.status
    fill_in "Txpower", with: @wlan.txpower
    fill_in "Wlan", with: @wlan.wlan
    click_on "Update Wlan"

    assert_text "Wlan was successfully updated"
    click_on "Back"
  end

  test "should destroy Wlan" do
    visit wlan_url(@wlan)
    click_on "Destroy this wlan", match: :first

    assert_text "Wlan was successfully destroyed"
  end
end
