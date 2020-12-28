defmodule StringsAndBinaries do
  def is_printable_ascii(chars) do
    Enum.all?(chars, &(?\s <= &1 && &1 <= ?~))
  end
end
