require "application_system_test_case"

class WlanclientsTest < ApplicationSystemTestCase
  setup do
    @wlanclient = wlanclients(:one)
  end

  test "visiting the index" do
    visit wlanclients_url
    assert_selector "h1", text: "Wlanclients"
  end

  test "should create wlanclient" do
    visit wlanclients_url
    click_on "New wlanclient"

    fill_in "Clientversion", with: @wlanclient.clientversion
    fill_in "Confighash", with: @wlanclient.confighash
    fill_in "Dateadded", with: @wlanclient.dateadded
    fill_in "Hwmodel", with: @wlanclient.hwmodel
    fill_in "Ipaddress", with: @wlanclient.ipaddress
    fill_in "Lastseen", with: @wlanclient.lastseen
    fill_in "Location", with: @wlanclient.location
    fill_in "Name", with: @wlanclient.name
    fill_in "Note", with: @wlanclient.note
    fill_in "Osversion", with: @wlanclient.osversion
    fill_in "Ownerid", with: @wlanclient.ownerid
    fill_in "Pollrate", with: @wlanclient.pollrate
    fill_in "Status", with: @wlanclient.status
    click_on "Create Wlanclient"

    assert_text "Wlanclient was successfully created"
    click_on "Back"
  end

  test "should update Wlanclient" do
    visit wlanclient_url(@wlanclient)
    click_on "Edit this wlanclient", match: :first

    fill_in "Clientversion", with: @wlanclient.clientversion
    fill_in "Confighash", with: @wlanclient.confighash
    fill_in "Dateadded", with: @wlanclient.dateadded
    fill_in "Hwmodel", with: @wlanclient.hwmodel
    fill_in "Ipaddress", with: @wlanclient.ipaddress
    fill_in "Lastseen", with: @wlanclient.lastseen
    fill_in "Location", with: @wlanclient.location
    fill_in "Name", with: @wlanclient.name
    fill_in "Note", with: @wlanclient.note
    fill_in "Osversion", with: @wlanclient.osversion
    fill_in "Ownerid", with: @wlanclient.ownerid
    fill_in "Pollrate", with: @wlanclient.pollrate
    fill_in "Status", with: @wlanclient.status
    click_on "Update Wlanclient"

    assert_text "Wlanclient was successfully updated"
    click_on "Back"
  end

  test "should destroy Wlanclient" do
    visit wlanclient_url(@wlanclient)
    click_on "Destroy this wlanclient", match: :first

    assert_text "Wlanclient was successfully destroyed"
  end
end
