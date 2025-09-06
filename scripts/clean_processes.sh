#!/usr/bin/env bash
set -euo pipefail

for process in "prettierd" "eslint_d"; do
    pids=($(pgrep $process))
    if [[ ${#pids[@]} -gt 1 ]]; then
        kill "${pids[@]:1}"
    fi
done
