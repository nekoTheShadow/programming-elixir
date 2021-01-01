# Protocols1.exsよりコピペ
defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    string
    |> to_charlist()
    |> Caesar.encrypt(shift)
    |> to_string()
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

defimpl Caesar, for: List do
  def encrypt(string, shift) do
    for ch <- string do
      if ch in ?a..?z do
        rem(ch - ?a + shift, 26) + ?a
      else
        ch
      end
    end
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end


defmodule Main do
  def run() do
    words = "Protocols2.txt" |> readline() |> MapSet.new()
    rot13s = words |> Enum.map(&Caesar.rot13/1) |> MapSet.new()
    MapSet.intersection(words, rot13s) |> Enum.each(&IO.puts/1)
  end

  def readline(path) do
    File.stream!(path)
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.downcase/1)
  end
end

Main.run()
