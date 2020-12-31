defmodule Stack.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Stack.Stash, ["a", "b", "c"]},
      {Stack.Server, []}
    ]

    opts = [strategy: :rest_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
