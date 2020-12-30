defmodule StringsAndBinaries do
  def is_printable_ascii(chars) do
    Enum.all?(chars, &(?\s <= &1 && &1 <= ?~))
  end

  def anagram?(word1, word2) do
    Enum.sort(word1) === Enum.sort(word2)
  end

  def calculate(statement) do
    x = Enum.find_index(statement, &(&1 in [?+, ?-, ?*, ?/]))

    op = Enum.slice(statement, x..x) |> List.to_atom()
    n1 = Enum.slice(statement, 0..x-1) |> List.to_integer()
    n2 = Enum.slice(statement, x+1..length(statement)-1) |> List.to_integer()

    apply(Kernel, op, [n1, n2])
  end

  def center(words) do
    maxlen = words |> Enum.map(&String.length/1) |> Enum.max
    for word <- words do
      len = div(maxlen-String.length(word), 2)
      IO.puts(String.duplicate(" ", len) <> word)
    end
  end

  def capitalize_sentences(sentences) do
    String.split(sentences, " ")
    |> Enum.map(&(capitalize &1))
    |> Enum.join(" ")
  end

  defp capitalize(<<head::utf8, tail::binary>>) do
    String.upcase(<<head::utf8>>) <> String.downcase(tail)
  end

  def run_sales_tax_from_csv() do
    tax_rates = [NC: 0.075, TX: 0.08]
    orders = File.stream!("StringsAndBinaries.csv")
              |> Enum.drop(1)
              |> Enum.map(&parse_line/1)
    Order.sales_tax(tax_rates, orders)
  end

  defp parse_line(line) do
    [id, ship_to, net_amount] = line |> String.trim() |> String.split(",")
    [
      id: id,
      ship_to: String.to_atom(ship_to),
      net_amount: String.to_float(net_amount),
    ]
  end
end
