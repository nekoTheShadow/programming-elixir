defmodule CSVSigil do
  def sigil_v(csv, _opts) do
    rows = csv
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))

    if rows === [] do
      []
    else
      headers = Enum.at(rows, 0) |> Enum.map(&String.to_atom/1)
      for row <- Enum.drop(rows, 1) do
        Enum.zip(headers, Enum.map(row, &parse/1)) |> Keyword.new()
      end
    end
  end

  defp parse(word) do
    case Integer.parse(word) do
      {integer, ""} -> integer
      _ ->
        case Float.parse(word) do
          {float, ""} -> float
          _ -> word
        end
    end
  end
end

ExUnit.start()

defmodule TestCSVSigil do
  use ExUnit.Case
  import CSVSigil

  test "~vシジルはヘッダ付きCSVをキーワードリストの配列に変換する。" do
    actual = ~v"""
    Item,Qty,Price
    Teddy bear,4,34.95
    Milk,1,2.99
    Battery,6,8.00
    """
    assert actual === [
      [Item: "Teddy bear", Qty: 4, Price: 34.95],
      [Item: "Milk", Qty: 1, Price: 2.99],
      [Item: "Battery", Qty: 6, Price: 8.00],
    ]
  end
end
