defmodule MyEnum do
  def all?([], _f) do
    true
  end

  def all?([head | tail], f) do
    f.(head) && all?(tail, f)
  end

  def all?([]) do
    true
  end

  def all?([head | tail]) do
    !!head && all?(tail)
  end

  def each([], _f) do
    :ok
  end

  def each([head | tail], f) do
    f.(head)
    each(tail, f)
  end

  def filter([], _f) do
    []
  end

  def filter([head | tail], f) do
    if f.(head) do
      [head | filter(tail, f)]
    else
      filter(tail, f)
    end
  end

  def split(list, n) when n >= 0 do
    split([], list, n)
  end

  def split(list, n) when n < 0 do
    split([], list, max(0, length(list)+n))
  end

  defp split(first, second, n) when length(second) == 0 or n == 0 do
    [first, second]
  end

  defp split(first, [head | tail], n) do
    split(first ++ [head], tail, n-1)
  end

  def take(list, n) when n < 0 do
    reverse(take(reverse(list), -n))
  end

  def take(list, n) when length(list) === 0 or n === 0 do
    []
  end

  def take([head | tail], n) do
    [head] ++ take(tail, n - 1)
  end

  defp reverse([]) do
    []
  end

  defp reverse([head | tail]) do
    reverse(tail) ++ [head]
  end
end
