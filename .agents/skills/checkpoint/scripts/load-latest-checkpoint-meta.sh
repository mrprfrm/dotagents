manifest=".checkpoints/MANIFEST.json"

if [ ! -s "$manifest" ]; then
  echo "0"
  echo ""
  echo ""
  echo "[]"
  echo "[]"
  exit 0
fi

latest_checkpoint_id="$(jq -r '.checkpoints[-1].checkpoint_id // 0' "$manifest")"
latest_recap="$(jq -r '.checkpoints[-1].recap // ""' "$manifest")"
latest_state="$(jq -r '.checkpoints[-1].state // ""' "$manifest")"
latest_commits="$(jq -c '[.checkpoints[].commits[]?] | unique' "$manifest")"
latest_knowledge="$(jq -c '[.checkpoints[].knowledge[]?] | unique' "$manifest")"

echo "$latest_checkpoint_id"
echo "$latest_recap"
echo "$latest_state"
echo "$latest_commits"
echo "$latest_knowledge"
