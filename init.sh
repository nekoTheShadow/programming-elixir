#!/bin/bash

all_exs=$(mktemp)
trap "rm -v ${all_exs}" EXIT

cat *.exs >> ${all_exs}
iex ${all_exs}