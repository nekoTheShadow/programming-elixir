defmodule Protocols3 do
  def each(list, f) do
    Enum.reduce(list, :ok, fn v, acc ->
      f.(v)
      acc
    end)
  end

  def filter(list, f) do
    list
    |> Enum.reduce([], fn (v, acc) -> if f.(v), do: [v|acc], else: acc end)
    |> Enum.reverse()
  end

  def map(list, f) do
    list
    |> Enum.reduce([], fn (v, acc) -> [f.(v)|acc] end)
    |> Enum.reverse()
  end
end

ExUnit.start()

defmodule Protocols3Caesar do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "eachはコールバック関数を逐次実行する" do
    actual = capture_io(fn ->
      ["A", "B", "C"] |> Protocols3.each(&IO.puts/1)
    end)
    assert actual === """
    A
    B
    C
    """
  end

  test "filterはコールバック関数がtrueを返す要素のみを集める" do
    assert Protocols3.filter([1, 2, 3, 4], fn v -> rem(v, 2) === 0 end) === [2, 4]
    assert Protocols3.filter([1, 2, 3, 4], fn _ -> false end) === []
  end

  test "mapはすべての要素をコールバック関数をもとに変換する" do
    assert Protocols3.map([1, 2, 3, 4], fn v -> rem(v, 2) end) === [1, 0, 1, 0]
    assert Protocols3.map([], fn v -> rem(v, 2) end) === []
  end
end
