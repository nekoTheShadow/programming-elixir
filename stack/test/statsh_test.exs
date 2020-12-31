defmodule StashTest do
  use ExUnit.Case

  setup do
    {:ok, _pid} = Stack.Stash.start_link(["A", "B", "C"])
    :ok
  end

  test "初期化時に設定した値をgetで取得する" do
    assert Stack.Stash.get() === ["A", "B", "C"]
  end

  test "updateで設定した値をgetで取得する" do
    Stack.Stash.update([1, 2, 3])
    assert Stack.Stash.get() === [1, 2, 3]
  end
end
