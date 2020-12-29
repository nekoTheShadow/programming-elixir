defmodule Client do
  def fetch(station_id) do
    "https://w1.weather.gov/xml/current_obs/#{station_id}.xml"
    |> HTTPoison.get()
    |> handle_response()
  end

  def handle_response({_, %{status_code: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({_, %{status_code: status_code}}) do
    {:error, "FAIL: Status Code is #{status_code}"}
  end
end
