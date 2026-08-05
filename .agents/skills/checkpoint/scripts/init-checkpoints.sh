mkdir -p .checkpoints
test -f .checkpoints/MANIFEST.json || printf '{ "last_id": 0, "checkpoints": [] }\n' > .checkpoints/MANIFEST.json
