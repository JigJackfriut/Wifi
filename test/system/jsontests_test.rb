require "application_system_test_case"

class JsontestsTest < ApplicationSystemTestCase
  setup do
    @jsontest = jsontests(:one)
  end

  test "visiting the index" do
    visit jsontests_url
    assert_selector "h1", text: "Jsontests"
  end

  test "should create jsontest" do
    visit jsontests_url
    click_on "New jsontest"

    fill_in "Config json", with: @jsontest.config_json
    click_on "Create Jsontest"

    assert_text "Jsontest was successfully created"
    click_on "Back"
  end

  test "should update Jsontest" do
    visit jsontest_url(@jsontest)
    click_on "Edit this jsontest", match: :first

    fill_in "Config json", with: @jsontest.config_json
    click_on "Update Jsontest"

    assert_text "Jsontest was successfully updated"
    click_on "Back"
  end

  test "should destroy Jsontest" do
    visit jsontest_url(@jsontest)
    click_on "Destroy this jsontest", match: :first

    assert_text "Jsontest was successfully destroyed"
  end
end
