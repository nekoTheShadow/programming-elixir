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

  def caeser([], _) do
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

  def flatten(list) do
    flatten(list, [])
  end

  defp flatten([], acc) do
    acc
  end

  defp flatten([head | tail], acc) when is_list(head) do
    flatten(head, flatten(tail, acc))
  end

  defp flatten([head | tail], acc) when not is_list(head) do
    [head | flatten(tail, acc)]
  end
end

defmodule Order do
  def apply_tax(tax_rates, orders) do
    for order <- orders do
      ship_to = Keyword.get(order, :ship_to)
      tax_rate = Keyword.get(tax_rates, ship_to, 0)
      total_amount = Keyword.get(order, :net_amount) * (1+tax_rate)
      Keyword.put(order, :total_amount, total_amount)
    end
  end

  def run() do
    tax_rates = [NC: 0.075, TX: 0.08]
    orders = [
      [id: 123, ship_to: :NC, net_amount: 100.00],
      [id: 124, ship_to: :OK, net_amount:  35.50],
      [id: 125, ship_to: :TX, net_amount:  24.00],
      [id: 126, ship_to: :TX, net_amount:  44.80],
      [id: 127, ship_to: :NC, net_amount:  25.00],
      [id: 128, ship_to: :MA, net_amount:  10.00],
      [id: 129, ship_to: :CA, net_amount: 102.00],
      [id: 120, ship_to: :NC, net_amount:  50.00]
    ]
    apply_tax(tax_rates, orders)
  end
end

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
