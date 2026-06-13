#!/bin/zsh

PACKAGE_JSON="./package.json"

# Check if package.json exists
if [[ ! -f "$PACKAGE_JSON" ]]; then
  echo "⚠️  package.json was not found in the current folder"
  exit 1
fi

# Parse scripts from package.json
function parse_scripts() {
  jq -r '.scripts | to_entries[] | "\(.key) | \(.value)"' "$PACKAGE_JSON"
}

# List scripts
function list_scripts() {
  echo "📜 Available npm scripts:"
  parse_scripts
  local count=$(jq '.scripts | length' "$PACKAGE_JSON")
  echo "✅ $count scripts found"
}

# Append command to Zsh history
function append_to_history() {
  local command="$1"
  print -s "$command"  # Add to session history
  fc -W                # Write to history file
}

# Run selected script
function run_script() {
  local title="$1"
  local command="npm run $title"

  echo "🚀 Running: $command"
  
  # Append to history
  append_to_history "$command"
  
  # Rename pane when running inside Zellij (if Zellij is used)
  [[ -n "$ZELLIJ" ]] && zellij action rename-pane "$title" 2>/dev/null

  # Execute command
  eval "$command"
  
  local exit_code=$?
  if [[ $exit_code -eq 0 ]]; then
    echo "✅ Script exited with code 0"
  else
    echo "❌ Script exited with code $exit_code"
  fi
}

# Interactive selection using fzf
function select_script() {
  local selection
  selection=$(parse_scripts | fzf --prompt="Select an npm script: " --height=20 --reverse)

  if [[ -z "$selection" ]]; then
    echo "No script selected."
    return 0
  fi

  local title=$(echo "$selection" | awk -F ' | ' '{print $1}')
  local script=$(echo "$selection" | cut -d'|' -f2- | sed 's/^ //')

  echo "🔍 Selected: $title"
  echo "📄 Command: $script"

  run_script "$title"
}

# Main
case "$1" in
  list)
    list_scripts
    ;;
  *)
    select_script
    ;;
esac
