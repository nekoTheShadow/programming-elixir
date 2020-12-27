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
