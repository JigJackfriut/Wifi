require "application_system_test_case"

class WificlientsTest < ApplicationSystemTestCase
  setup do
    @wificlient = wificlients(:one)
  end

  test "visiting the index" do
    visit wificlients_url
    assert_selector "h1", text: "Wificlients"
  end

  test "should create wificlient" do
    visit wificlients_url
    click_on "New wificlient"

    fill_in "Clientversion", with: @wificlient.clientversion
    fill_in "Confighash", with: @wificlient.confighash
    fill_in "Dateadded", with: @wificlient.dateadded
    check "Enabled" if @wificlient.enabled
    fill_in "Hwmodel", with: @wificlient.hwmodel
    fill_in "Ipaddress", with: @wificlient.ipaddress
    fill_in "Lastseen", with: @wificlient.lastseen
    fill_in "Location", with: @wificlient.location
    fill_in "Name", with: @wificlient.name
    fill_in "Note", with: @wificlient.note
    fill_in "Osversion", with: @wificlient.osversion
    fill_in "Ownerid", with: @wificlient.ownerid
    fill_in "Pollrate", with: @wificlient.pollrate
    fill_in "Status", with: @wificlient.status
    click_on "Create Wificlient"

    assert_text "Wificlient was successfully created"
    click_on "Back"
  end

  test "should update Wificlient" do
    visit wificlient_url(@wificlient)
    click_on "Edit this wificlient", match: :first

    fill_in "Clientversion", with: @wificlient.clientversion
    fill_in "Confighash", with: @wificlient.confighash
    fill_in "Dateadded", with: @wificlient.dateadded
    check "Enabled" if @wificlient.enabled
    fill_in "Hwmodel", with: @wificlient.hwmodel
    fill_in "Ipaddress", with: @wificlient.ipaddress
    fill_in "Lastseen", with: @wificlient.lastseen
    fill_in "Location", with: @wificlient.location
    fill_in "Name", with: @wificlient.name
    fill_in "Note", with: @wificlient.note
    fill_in "Osversion", with: @wificlient.osversion
    fill_in "Ownerid", with: @wificlient.ownerid
    fill_in "Pollrate", with: @wificlient.pollrate
    fill_in "Status", with: @wificlient.status
    click_on "Update Wificlient"

    assert_text "Wificlient was successfully updated"
    click_on "Back"
  end

  test "should destroy Wificlient" do
    visit wificlient_url(@wificlient)
    click_on "Destroy this wificlient", match: :first

    assert_text "Wificlient was successfully destroyed"
  end
end
