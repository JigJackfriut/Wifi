require "application_system_test_case"

class UserzonesTest < ApplicationSystemTestCase
  setup do
    @userzone = userzones(:one)
  end

  test "visiting the index" do
    visit userzones_url
    assert_selector "h1", text: "Userzones"
  end

  test "should create userzone" do
    visit userzones_url
    click_on "New userzone"

    fill_in "Pmk", with: @userzone.pmk
    fill_in "User", with: @userzone.user_id
    fill_in "Zone", with: @userzone.zone_id
    click_on "Create Userzone"

    assert_text "Userzone was successfully created"
    click_on "Back"
  end

  test "should update Userzone" do
    visit userzone_url(@userzone)
    click_on "Edit this userzone", match: :first

    fill_in "Pmk", with: @userzone.pmk
    fill_in "User", with: @userzone.user_id
    fill_in "Zone", with: @userzone.zone_id
    click_on "Update Userzone"

    assert_text "Userzone was successfully updated"
    click_on "Back"
  end

  test "should destroy Userzone" do
    visit userzone_url(@userzone)
    click_on "Destroy this userzone", match: :first

    assert_text "Userzone was successfully destroyed"
  end
end
