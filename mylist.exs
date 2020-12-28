defmodule MyList do
  def mapsum([], _f) do
    0
  end

  def mapsum([head | tail], f) do
    f.(head) + mapsum(tail, f)
  end

  def max([a]) do
    a
  end

  def max([a, b]) when a <= b do
    b
  end

  def max([a, b]) when a > b do
    a
  end

  def max([head | tail]) do
    max(head, max(tail))
  end
end
