require "application_system_test_case"

class StationLogsTest < ApplicationSystemTestCase
  setup do
    @station_log = station_logs(:one)
  end

  test "visiting the index" do
    visit station_logs_url
    assert_selector "h1", text: "Station logs"
  end

  test "should create station log" do
    visit station_logs_url
    click_on "New station log"

    fill_in "Ap", with: @station_log.AP
    fill_in "Associated", with: @station_log.associated
    fill_in "Channel", with: @station_log.channel
    fill_in "Event", with: @station_log.event
    fill_in "Expected throughput", with: @station_log.expected_throughput
    fill_in "Interface", with: @station_log.interface
    fill_in "Mac", with: @station_log.mac
    fill_in "Rx bitrate", with: @station_log.rx_bitrate
    fill_in "Rx bytes", with: @station_log.rx_bytes
    fill_in "Signal", with: @station_log.signal
    fill_in "Signal avg", with: @station_log.signal_avg
    fill_in "Ssid", with: @station_log.ssid
    fill_in "Station", with: @station_log.station
    fill_in "Tx bitrate", with: @station_log.tx_bitrate
    fill_in "Tx bytes", with: @station_log.tx_bytes
    fill_in "Tx failed", with: @station_log.tx_failed
    fill_in "Tx retries", with: @station_log.tx_retries
    fill_in "User", with: @station_log.user_id
    fill_in "Vid", with: @station_log.vid
    click_on "Create Station log"

    assert_text "Station log was successfully created"
    click_on "Back"
  end

  test "should update Station log" do
    visit station_log_url(@station_log)
    click_on "Edit this station log", match: :first

    fill_in "Ap", with: @station_log.AP
    fill_in "Associated", with: @station_log.associated
    fill_in "Channel", with: @station_log.channel
    fill_in "Event", with: @station_log.event
    fill_in "Expected throughput", with: @station_log.expected_throughput
    fill_in "Interface", with: @station_log.interface
    fill_in "Mac", with: @station_log.mac
    fill_in "Rx bitrate", with: @station_log.rx_bitrate
    fill_in "Rx bytes", with: @station_log.rx_bytes
    fill_in "Signal", with: @station_log.signal
    fill_in "Signal avg", with: @station_log.signal_avg
    fill_in "Ssid", with: @station_log.ssid
    fill_in "Station", with: @station_log.station
    fill_in "Tx bitrate", with: @station_log.tx_bitrate
    fill_in "Tx bytes", with: @station_log.tx_bytes
    fill_in "Tx failed", with: @station_log.tx_failed
    fill_in "Tx retries", with: @station_log.tx_retries
    fill_in "User", with: @station_log.user_id
    fill_in "Vid", with: @station_log.vid
    click_on "Update Station log"

    assert_text "Station log was successfully updated"
    click_on "Back"
  end

  test "should destroy Station log" do
    visit station_log_url(@station_log)
    click_on "Destroy this station log", match: :first

    assert_text "Station log was successfully destroyed"
  end
end
