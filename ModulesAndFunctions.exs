defmodule Times do
  def double(n) do
    n * 2
  end

  def triple(n) do
    n * 3
  end

  def quadruple(n) do
    double(double(n))
  end
end

defmodule Sum do
  def sum(1) do
    1
  end

  def sum(n) do
    sum(n-1) + n
  end
end

defmodule Gcd do
  def gcd(n, 0) do
    n
  end

  def gcd(n, m) do
    gcd(m, rem(n, m))
  end
end

defmodule Chop do
  def guess(actual, a..b) do
    mid = div(a+b, 2)
    IO.puts "It is #{mid}"
    bsearch(actual, a..b, mid)
  end

  def bsearch(actual, _.._, mid) when actual === mid do
    actual
  end

  def bsearch(actual, a.._, mid) when actual < mid do
    guess(actual, a..mid)
  end

  def bsearch(actual, _..b, mid) when mid < actual do
    guess(actual, mid..b)
  end
end
