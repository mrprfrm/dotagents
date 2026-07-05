manifest=".checkpoints/MANIFEST.json"

current_checkpoint_id="$1"
checkpoint_name="$2"
current_recap="$3"
current_state="$4"

checkpoint_path=".checkpoints/${current_checkpoint_id}-${checkpoint_name}.md"

if [ ! -s "$manifest" ]; then
  echo '{"checkpoints":[]}' > "$manifest"
fi

tmp="$(mktemp)"

jq \
  --argjson checkpoint_id "$current_checkpoint_id" \
  --arg checkpoint_name "$checkpoint_name" \
  --arg checkpoint_path "$checkpoint_path" \
  --arg recap "$current_recap" \
  --arg state "$current_state" \
  '
  .checkpoints = ((.checkpoints // []) + [{
    "checkpoint_id": $checkpoint_id,
    "checkpoint_name": $checkpoint_name,
    "checkpoint_path": $checkpoint_path,
    "recap": $recap,
    "state": $state
  }])
  ' "$manifest" > "$tmp"

mv "$tmp" "$manifest"
