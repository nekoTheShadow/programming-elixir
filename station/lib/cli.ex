defmodule CLI do
  def main(argv) do
    argv
    |> parse_argv()
    |> process()
  end

  def parse_argv(["list"]), do: [subcmd: :list]
  def parse_argv(["help"]), do: [subcmd: :help]
  def parse_argv([station_id]), do: [subcmd: :find, station_id: station_id]
  def parse_argv(_), do: [subcmd: :help]

  def process([subcmd: :help]) do
    IO.puts """
    Usage:
      station <command>
    The commands are:
      help         : print help message
      list         : print all station ids
      <station_id> : fetch <station_id>'s infomaion from National Weather Service
    """
  end

  def process([subcmd: :list]) do
    case Client.fetch("index") do
      {:ok, body} -> body |> parse_for_list() |> pretty_print()
      {:error, message} -> IO.puts(message)
    end
  end

  def process([subcmd: :find, station_id: station_id]) do
    case Client.fetch(station_id) do
      {:ok, body} -> body |> parse_for_find() |> pretty_print()
      {:error, message} -> IO.puts(message)
    end
  end

  def pretty_print({keys, values}) do
    key_len = keys |> Enum.map(&String.length/1) |> Enum.max()
    value_len = values |> Enum.map(&String.length/1) |> Enum.max()

    for {key, value} <- Enum.zip(keys, values) do
      IO.puts padding(key, key_len) <> " | " <> padding(value, value_len)
    end
  end

  def padding(str, len) do
    str <> String.duplicate(" ", len - String.length(str))
  end

  def parse_for_list(body) do
    {
      Regex.scan(~r/<station_id>(.*)<\/station_id>/, body) |> Enum.map(&Enum.at(&1, 1)),
      Regex.scan(~r/<station_name>(.*)<\/station_name>/, body) |> Enum.map(&Enum.at(&1, 1)),
    }
  end

  def parse_for_find(body) do
    elements = Regex.scan(~r/<(.*?)>(.*?)<\/\1>/, body) |> Enum.map(&({Enum.at(&1, 1), Enum.at(&1, 2)}))
    keys = for {key, _} <- elements, do: key
    values = for {_, value} <- elements, do: value
    {keys, values}
  end
end
