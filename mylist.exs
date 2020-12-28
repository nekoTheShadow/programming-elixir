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

  def caeser([], n) do
    []
  end

  def caeser([head | tail], n) when ?a <= head and head <= ?z do
    [?a + rem((head - ?a + n), 26) | caeser(tail, n)]
  end

  def span(from, to) when from > to do
    []
  end

  def span(from, to) do
    [from | span(from+1, to)]
  end
end
