defmodule CSVSigil do
  def sigil_v(csv, _opts) do
    rows = csv
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))

    for row <- rows do
      Enum.map(row, &parse/1)
    end
  end

  defp parse(word) do
    case Float.parse(word) do
      {float, ""} -> float
      _ -> word
    end
  end
end

ExUnit.start()

defmodule TestCSVSigil do
  use ExUnit.Case
  import CSVSigil

  test "~vシジルはcsvを2次元配列に変換する。セルが数値の場合はfloatに変換する" do
    actual = ~v"""
    1,2,3.14
    cat,dog
    1A,2B,3C
    """
    assert actual === [[1.0, 2.0, 3.14], ["cat", "dog"], ["1A", "2B", "3C"]]
  end
end
