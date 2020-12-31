defmodule ServerTest do
  use ExUnit.Case

  setup do
    {:ok, _pid} = Stack.Stash.start_link(["A", "B", "C"])
    {:ok, _pid} = Stack.Server.start_link([])
    :ok
  end

  test "初期化時に設定した値をpopで取得する" do
    assert Stack.Server.pop() === "A"
    assert Stack.Server.pop() === "B"
    assert Stack.Server.pop() === "C"
  end

  test "pushで設定した値をpopで取得する" do
    Stack.Server.push(1)
    Stack.Server.push(2)
    Stack.Server.push(3)
    assert Stack.Server.pop() === 3
    assert Stack.Server.pop() === 2
    assert Stack.Server.pop() === 1
  end

end
