defmodule Person do
  defstruct name: "", age: 0

  def new(name, age) do
    %Person{name: name, age: age}
  end
end

defimpl Inspect, for: Person do
  def inspect(%Person{name: name, age: age}, _) do
    "%Person{age: #{age}, name: \"#{name}\"}"
  end
end

ExUnit.start()

defmodule TestPerson do
  use ExUnit.Case

  test "inspectの再定義を試みる" do
    person = Person.new("John Lenon", 40)
    assert inspect(person) === "%Person{age: 40, name: \"John Lenon\"}"
  end
end
