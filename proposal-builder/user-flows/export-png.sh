#!/usr/bin/env bash
# Export every .mermaid file under user-flows/*/ to a same-named .png alongside it.
# mmdc's default 800px viewport shrinks any diagram wider than that to fit,
# which shrinks node/font size on big diagrams while small ones render at
# true size — mermaid-config.json (useMaxWidth: false) disables that shrink
# so every diagram renders at its natural pixel size before the 3x scale,
# keeping node/font size identical across files regardless of diagram size.
set -euo pipefail
cd "$(dirname "$0")"

for f in */*.mermaid; do
  out="${f%.mermaid}.png"
  echo "→ $f"
  npx -y -p @mermaid-js/mermaid-cli mmdc -i "$f" -o "$out" -b white -s 3 -c mermaid-config.json
done
