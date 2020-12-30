#!/bin/bash

tempdir="$(mktemp -d)"
trap "rm -rf ${tempdir}" EXIT

for ((x=1;x<=100;x++)); do
  cat /dev/urandom | tr -cd cat | fold -w80 | head -n80 > ${tempdir}/${x}.txt
done

elixir -r WorkingWithMultipleProcesses9.exs -e "Main.main(\"${tempdir}\", 10)"
