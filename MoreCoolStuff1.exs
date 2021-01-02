defmodule CSVSigil do
  def sigil_v(csv, _opts) do
    csv
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
  end
end

ExUnit.start()

defmodule TestCSVSigil do
  use ExUnit.Case
  import CSVSigil

  test "~vシジルはcsvを2次元配列に変換する" do
    actual = ~v"""
    1,2,3
    cat,dog
    """
    assert actual === [["1", "2", "3"], ["cat", "dog"]]
  end
end
