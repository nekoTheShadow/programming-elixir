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

ExUnit.start()

defmodule TestCaesar do
  use ExUnit.Case

  test "Caesar.encryptはシーザー暗号を実装する" do
    assert Caesar.encrypt("abc'xyz", 2) === "cde'zab"
    assert Caesar.encrypt('abc\'xyz', 2) === 'cde\'zab'
  end

  test "Caesar.rot13はROT13を実装する。" do
    assert Caesar.rot13("abc'xyz") === "nop'klm"
    assert Caesar.rot13('abc\'xyz') === 'nop\'klm'
  end
end
