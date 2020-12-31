defmodule My do
  defmacro explain({op, _meta, [left, right]}) do
    {_, msgs} = pretty(op, left, right, [])
    msgs |> Enum.reverse() |> Enum.each(&IO.puts/1)
  end

  def pretty(op, left, right, msgs) do
    {v1, msgs1} = case left do
      {op1, _meta, [left1, right1]} -> pretty(op1, left1, right1, msgs)
      n1 -> {n1, []}
    end
    {v2, msgs2} = case right do
      {op2, _meta, [left2, right2]} -> pretty(op2, left2, right2, msgs)
      n2 -> {n2, []}
    end
    case op do
      :+ -> {v1 + v2, ["#{v1}と#{v2}を足す ---> #{v1+v2}"] ++ msgs2 ++ msgs1 ++ msgs}
      :- -> {v1 - v2, ["#{v1}から#{v2}を引く ---> #{v1-v2}"] ++ msgs2 ++ msgs1 ++ msgs}
      :* -> {v1 * v2, ["#{v1}と#{v2}をかける ---> #{v1*v2}"] ++ msgs2 ++ msgs1 ++ msgs}
      :/ -> {v1 / v2, ["#{v1}から#{v2}を割る ---> #{v1/v2}"] ++ msgs2 ++ msgs1 ++ msgs}
    end
  end
end

defmodule Test do
  require My
  My.explain(1 + 2 + 3)
  My.explain(1 + 2 * 3)
  My.explain(1 * 2 + 3 * 4)
end
