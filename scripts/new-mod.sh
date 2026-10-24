#!/usr/bin/env bash
# Creates a new mod repository from this template.
#
#   scripts/new-mod.sh <mod-name> [<dest-dir>] ["<one-line description>"]
#
# <mod-name> is lowercase letters, digits and hyphens (it becomes the plugin
# name, the command and the $.state key). <dest-dir> defaults to
# ../claude-<mod-name> beside this template. The copy leaves out .git and
# generated files, renames every `mod-template` to <mod-name>, drops the
# template-only scripts/new-mod.sh, runs `git init` and makes one commit.
set -euo pipefail

name="${1:?usage: new-mod.sh <mod-name> [<dest-dir>] [description]}"
[[ "$name" =~ ^[a-z][a-z0-9-]{0,62}$ ]] || { echo "bad mod name: $name" >&2; exit 2; }
template="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dest="${2:-$(dirname "$template")/claude-$name}"
desc="${3:-}"

[[ -e "$dest" ]] && { echo "already exists: $dest" >&2; exit 2; }
mkdir -p "$dest"
rsync -a --exclude .git --exclude .claude-plugin/types --exclude tsconfig.json --exclude .DS_Store \
  --exclude scripts/new-mod.sh "$template/" "$dest/"

# Rename the placeholder everywhere (file contents only; no file is named after it).
grep -rl --exclude-dir=.git 'mod-template' "$dest" | while IFS= read -r f; do
  sed -i '' -e "s/claude-mod-template/claude-$name/g" -e "s/mod-template/$name/g" "$f"
done
if [[ -n "$desc" ]]; then
  jq --arg d "$desc" '.description = $d' "$dest/.claude-plugin/plugin.json" >"$dest/.claude-plugin/plugin.json.new"
  mv "$dest/.claude-plugin/plugin.json.new" "$dest/.claude-plugin/plugin.json"
  jq --arg d "$desc" '.description = $d' "$dest/.claude-plugin/marketplace.json" >"$dest/.claude-plugin/marketplace.json.new"
  mv "$dest/.claude-plugin/marketplace.json.new" "$dest/.claude-plugin/marketplace.json"
fi

git -C "$dest" init -q -b main
git -C "$dest" add -A
git -C "$dest" commit -q -m "chore: scaffold $name from claude-mod-template"
echo "created $dest"
