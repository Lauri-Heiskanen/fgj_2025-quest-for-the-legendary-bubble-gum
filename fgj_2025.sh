#!/bin/sh
echo -ne '\033c\033]0;fgj_2025\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/fgj_2025.x86_64" "$@"
