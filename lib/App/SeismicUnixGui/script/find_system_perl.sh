#!/bin/bash
# Jan. 18, 2026
# Locate a system perl installation, avoiding conda/mamba/venv environments.

set -euo pipefail

find_system_perl() {
  mapfile -t PERLS < <(type -aP perl 2>/dev/null | awk '!seen[$0]++')
  ((${#PERLS[@]})) || { echo "ERROR: no perl found on PATH" >&2; return 1; }

  if [[ -x /usr/bin/perl ]]; then
    echo "/usr/bin/perl"
    return 0
  fi

  local p
  for p in "${PERLS[@]}"; do
    case "$p" in
      */anaconda*/*|*/miniconda*/*|*/mambaforge*/*|*/conda*/*|*/micromamba*/*|*/.conda/*|*/envs/*|*/.venv/*|*/venv/*)
        continue
        ;;
      *)
        echo "$p"
        return 0
        ;;
    esac
  done

  echo "ERROR: couldn't identify a system perl" >&2
  return 1
}