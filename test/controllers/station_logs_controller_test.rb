require "test_helper"

class StationLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @station_log = station_logs(:one)
  end

  test "should get index" do
    get station_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_station_log_url
    assert_response :success
  end

  test "should create station_log" do
    assert_difference("StationLog.count") do
      post station_logs_url, params: { station_log: { AP: @station_log.AP, associated: @station_log.associated, channel: @station_log.channel, event: @station_log.event, expected_throughput: @station_log.expected_throughput, interface: @station_log.interface, mac: @station_log.mac, rx_bitrate: @station_log.rx_bitrate, rx_bytes: @station_log.rx_bytes, signal: @station_log.signal, signal_avg: @station_log.signal_avg, ssid: @station_log.ssid, station: @station_log.station, tx_bitrate: @station_log.tx_bitrate, tx_bytes: @station_log.tx_bytes, tx_failed: @station_log.tx_failed, tx_retries: @station_log.tx_retries, user_id: @station_log.user_id, vid: @station_log.vid } }
    end

    assert_redirected_to station_log_url(StationLog.last)
  end

  test "should show station_log" do
    get station_log_url(@station_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_station_log_url(@station_log)
    assert_response :success
  end

  test "should update station_log" do
    patch station_log_url(@station_log), params: { station_log: { AP: @station_log.AP, associated: @station_log.associated, channel: @station_log.channel, event: @station_log.event, expected_throughput: @station_log.expected_throughput, interface: @station_log.interface, mac: @station_log.mac, rx_bitrate: @station_log.rx_bitrate, rx_bytes: @station_log.rx_bytes, signal: @station_log.signal, signal_avg: @station_log.signal_avg, ssid: @station_log.ssid, station: @station_log.station, tx_bitrate: @station_log.tx_bitrate, tx_bytes: @station_log.tx_bytes, tx_failed: @station_log.tx_failed, tx_retries: @station_log.tx_retries, user_id: @station_log.user_id, vid: @station_log.vid } }
    assert_redirected_to station_log_url(@station_log)
  end

  test "should destroy station_log" do
    assert_difference("StationLog.count", -1) do
      delete station_log_url(@station_log)
    end

    assert_redirected_to station_logs_url
  end
end
