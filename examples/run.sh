#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_room_space info
PYTHONPATH=src python -m gbt_room_space check --payload '{}'
PYTHONPATH=src python -m gbt_room_space run   --payload '{}'
