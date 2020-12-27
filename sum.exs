defmodule Sum do
  def sum(1) do
    1
  end

  def sum(n) do
    sum(n-1) + n
  end
end
