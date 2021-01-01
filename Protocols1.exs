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
    string
    |> Enum.map(&(rem(&1-?a+shift, 26) + ?a))
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

ExUnit.start()

defmodule TestCaesar do
  use ExUnit.Case

  test "Caesar.encryptはシーザー暗号を実装する" do
    assert Caesar.encrypt("abcxyz", 2) === "cdezab"
    assert Caesar.encrypt('abcxyz', 2) === 'cdezab'
  end

  test "Caesar.rot13はROT13を実装する。" do
    assert Caesar.rot13("abcxyz") === "nopklm"
    assert Caesar.rot13('abcxyz') === 'nopklm'
  end
end
