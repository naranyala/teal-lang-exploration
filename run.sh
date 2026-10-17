#!/usr/bin/env bash

set -eu

project_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
cd "$project_dir"

if ! command -v tl >/dev/null 2>&1; then
   echo "error: Teal compiler (tl) is not installed or not on PATH" >&2
   exit 1
fi

if ! command -v love >/dev/null 2>&1; then
   echo "error: LÖVE is not installed or not on PATH" >&2
   exit 1
fi

make build
exec love .
