#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
	echo "usage: $0 <markdown-file>" >&2
	exit 64
fi

md_path="$1"

if [[ ! -f "$md_path" ]]; then
	echo "explain render: markdown file not found: $md_path" >&2
	exit 66
fi

if ! command -v pandoc >/dev/null 2>&1; then
	echo "explain render: pandoc is required but was not found" >&2
	exit 69
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
css_path="$(cd -- "$script_dir/../assets" && pwd)/style.css"

if [[ ! -f "$css_path" ]]; then
	echo "explain render: stylesheet not found: $css_path" >&2
	exit 66
fi

case "$md_path" in
*.md) html_path="${md_path%.md}.html" ;;
*.markdown) html_path="${md_path%.markdown}.html" ;;
*) html_path="$md_path.html" ;;
esac

title="$(basename -- "$html_path")"
title="${title%.html}"

pandoc --standalone --section-divs --css "$css_path" --metadata "title=$title" -o "$html_path" "$md_path"

if command -v xdg-open >/dev/null 2>&1; then
	xdg-open "$html_path" >/dev/null 2>&1 &
elif command -v open >/dev/null 2>&1; then
	open "$html_path" >/dev/null 2>&1 &
elif command -v cmd.exe >/dev/null 2>&1; then
	win_path="$(wslpath -w "$html_path" 2>/dev/null || printf '%s' "$html_path")"
	cmd.exe /c start "" "$win_path" >/dev/null 2>&1 &
else
	echo "explain render: rendered $html_path but no browser opener was found" >&2
	echo "$html_path"
	exit 70
fi

echo "$html_path"
