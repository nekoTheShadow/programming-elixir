defmodule MyList do
  def mapsum([], _f) do
    0
  end

  def mapsum([head | tail], f) do
    f.(head) + mapsum(tail, f)
  end
end
