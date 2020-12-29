defmodule CLITest do
  use ExUnit.Case
  import CLI
  import ExUnit.CaptureIO

  test "test parse_argv" do
    assert parse_argv(["list"]) === [subcmd: :list]
    assert parse_argv(["help"]) === [subcmd: :help]
    assert parse_argv(["KDTO"]) === [subcmd: :find, station_id: "KDTO"]
    assert parse_argv(["list", "help"]) === [subcmd: :help]
    assert parse_argv([]) === [subcmd: :help]
  end

  test "test pretty_print" do
    actual = capture_io(fn -> pretty_print({["key1*", "key2**"], ["value1*", "value2**"]}) end)
    expected = """
    key1*  | value1*_
    key2** | value2**
    """
    assert String.replace(expected, "_", " ") === actual
  end

  test "test parse_for_list" do
    body = """
    <wx_station_index>
      <credit>NOAA's National Weather Service</credit>
      <credit_URL>http://weather.gov/</credit_URL>
      <image>
        <url>http://weather.gov/images/xml_logo.gif</url>
        <title>NOAA's National Weather Service</title>
        <link>http://weather.gov</link>
      </image>
      <suggested_pickup>08:00 EST</suggested_pickup>
      <suggested_pickup_period>1140</suggested_pickup_period>
      <station>
        <station_id>CWZW</station_id>
        <state>YT</state>
        <station_name>Teslin Marine Aviation Reporting Station</station_name>
        <latitude>60.16667</latitude>
        <longitude>-132.76667</longitude>
        <html_url>http://w1.weather.gov/data/obhistory/CWZW.html</html_url>
        <rss_url>http://weather.gov/xml/current_obs/CWZW.rss</rss_url>
        <xml_url>http://weather.gov/xml/current_obs/CWZW.xml</xml_url>
      </station>
      <station>
        <station_id>CYXY</station_id>
        <state>YT</state>
        <station_name>Erik Nielsen Whitehorse International Airport</station_name>
        <latitude>60.71667</latitude>
        <longitude>-135.06667</longitude>
        <html_url>http://w1.weather.gov/data/obhistory/CYXY.html</html_url>
        <rss_url>http://weather.gov/xml/current_obs/CYXY.rss</rss_url>
        <xml_url>http://weather.gov/xml/current_obs/CYXY.xml</xml_url>
      </station>
    </wx_station_index>
    """

    assert parse_for_list(body) === {["CWZW", "CYXY"], ["Teslin Marine Aviation Reporting Station", "Erik Nielsen Whitehorse International Airport"]}
  end

  test "test parse_for_find" do
    body = """
    <?xml version="1.0" encoding="ISO-8859-1"?>
    <?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>
    <current_observation version="1.0"
      xmlns:xsd="http://www.w3.org/2001/XMLSchema"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:noNamespaceSchemaLocation="http://www.weather.gov/view/current_observation.xsd">
      <credit>NOAA's National Weather Service</credit>
      <credit_URL>http://weather.gov/</credit_URL>
      <image>
        <url>http://weather.gov/images/xml_logo.gif</url>
        <title>NOAA's National Weather Service</title>
        <link>http://weather.gov</link>
      </image>
      <suggested_pickup>15 minutes after the hour</suggested_pickup>
      <suggested_pickup_period>60</suggested_pickup_period>
    </current_observation>
    """

    assert parse_for_find(body) === {
      ["credit", "credit_URL", "url", "title", "link", "suggested_pickup", "suggested_pickup_period"],
      ["NOAA's National Weather Service", "http://weather.gov/", "http://weather.gov/images/xml_logo.gif", "NOAA's National Weather Service", "http://weather.gov", "15 minutes after the hour", "60"]
    }
  end
end
