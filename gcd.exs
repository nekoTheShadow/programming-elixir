defmodule Gcd do
  def gcd(n, 0) do
    n
  end

  def gcd(n, m) do
    gcd(m, rem(n, m))
  end
end
