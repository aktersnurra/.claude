#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
	echo "usage: $0 <slides-markdown-file>" >&2
	exit 64
fi

md_path="$1"

if [[ ! -f "$md_path" ]]; then
	echo "explain slides: markdown file not found: $md_path" >&2
	exit 66
fi

case "$md_path" in
*-slides.md) html_path="${md_path%.md}.html" ;;
*-slides.markdown) html_path="${md_path%.markdown}.html" ;;
*)
	echo "explain slides: expected a condensed slide source named *-slides.md" >&2
	echo "explain slides: do not render the long-form reading document directly" >&2
	exit 65
	;;
esac

if ! command -v pandoc >/dev/null 2>&1; then
	echo "explain slides: pandoc is required but was not found" >&2
	exit 69
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
assets_dir="$(cd -- "$script_dir/../assets" && pwd)"
css_path="$assets_dir/slides.css"
after_body_path="$assets_dir/slides-after-body.html"

if [[ ! -f "$css_path" ]]; then
	echo "explain slides: stylesheet not found: $css_path" >&2
	exit 66
fi

if [[ ! -f "$after_body_path" ]]; then
	echo "explain slides: slide controller not found: $after_body_path" >&2
	exit 66
fi

title="$(basename -- "$html_path")"
title="${title%.html}"

pandoc --standalone --section-divs --css "$css_path" --include-after-body "$after_body_path" --metadata "title=$title" -o "$html_path" "$md_path"

if command -v xdg-open >/dev/null 2>&1; then
	xdg-open "$html_path" >/dev/null 2>&1 &
elif command -v open >/dev/null 2>&1; then
	open "$html_path" >/dev/null 2>&1 &
elif command -v cmd.exe >/dev/null 2>&1; then
	win_path="$(wslpath -w "$html_path" 2>/dev/null || printf '%s' "$html_path")"
	cmd.exe /c start "" "$win_path" >/dev/null 2>&1 &
else
	echo "explain slides: rendered $html_path but no browser opener was found" >&2
	echo "$html_path"
	exit 70
fi

echo "$html_path"
