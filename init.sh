#!/bin/bash

all_ex=$(mktemp)
trap "rm -v ${all_ex}" EXIT

cat *.ex >> ${all_ex}
iex ${all_ex}