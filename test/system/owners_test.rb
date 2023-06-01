require "application_system_test_case"

class OwnersTest < ApplicationSystemTestCase
  setup do
    @owner = owners(:one)
  end

  test "visiting the index" do
    visit owners_url
    assert_selector "h1", text: "Owners"
  end

  test "should create owner" do
    visit owners_url
    click_on "New owner"

    fill_in "Address1", with: @owner.address1
    fill_in "Address2", with: @owner.address2
    fill_in "City", with: @owner.city
    fill_in "Email", with: @owner.email
    fill_in "First name", with: @owner.first_name
    fill_in "Last name", with: @owner.last_name
    fill_in "Phone", with: @owner.phone
    fill_in "State", with: @owner.state
    fill_in "Type", with: @owner.type
    fill_in "Zip", with: @owner.zip
    click_on "Create Owner"

    assert_text "Owner was successfully created"
    click_on "Back"
  end

  test "should update Owner" do
    visit owner_url(@owner)
    click_on "Edit this owner", match: :first

    fill_in "Address1", with: @owner.address1
    fill_in "Address2", with: @owner.address2
    fill_in "City", with: @owner.city
    fill_in "Email", with: @owner.email
    fill_in "First name", with: @owner.first_name
    fill_in "Last name", with: @owner.last_name
    fill_in "Phone", with: @owner.phone
    fill_in "State", with: @owner.state
    fill_in "Type", with: @owner.type
    fill_in "Zip", with: @owner.zip
    click_on "Update Owner"

    assert_text "Owner was successfully updated"
    click_on "Back"
  end

  test "should destroy Owner" do
    visit owner_url(@owner)
    click_on "Destroy this owner", match: :first

    assert_text "Owner was successfully destroyed"
  end
end
