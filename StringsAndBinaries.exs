defmodule StringsAndBinaries do
  def is_printable_ascii(chars) do
    Enum.all?(chars, &(?\s <= &1 && &1 <= ?~))
  end

  def anagram?(word1, word2) do
    Enum.sort(String.to_charlist(word1)) === Enum.sort(String.to_charlist(word2))
  end
end
