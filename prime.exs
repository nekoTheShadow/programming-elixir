defmodule Prime do
  def primes(n) do
    sieve(MyList.span(2, n))
  end

  defp sieve([]) do
    []
  end

  defp sieve([head | tail]) do
    [head | sieve(for x <- tail, rem(x, head)===0, do: x)]
  end
end
