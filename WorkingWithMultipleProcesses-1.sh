#!/bin/bash

{
    elixir -r chain.exs -e "Chain.run(10)"
    elixir -r chain.exs -e "Chain.run(100)"
    elixir -r chain.exs -e "Chain.run(1000)"
    elixir -r chain.exs -e "Chain.run(10000)"
    elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(400000)"
    elixir --erl "+P 1000000" -r chain.exs -e "Chain.run(1000000)"
} > text/WorkingWithMultipleProcesses-1.txt