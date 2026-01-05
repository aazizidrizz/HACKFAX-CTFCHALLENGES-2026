#!/bin/bash
set -euo pipefail

echo "[*] Writing README for CTF Level 2..."

LEVEL_DIR="/home/student/CTF_Challenges/level2"

mkdir -p "$LEVEL_DIR" || { echo "Failed to create directory"; exit 1; }
cd "$LEVEL_DIR" || { echo "Failed to access directory"; exit 1; }

# Clean old readme/hint
rm -f README.txt HINT.txt 2>/dev/null || true

cat > README.txt <<'EOF'
CTF Level 2: Hidden Valentine

Story:
A secret admirer left a note… but they’re shy.

Objective:
Find the REAL flag.

Rules:
- No brute force needed.
- Everything you need is inside this folder.

Hints:
- Some files don’t appear in normal directory listings.
- Read carefully: not every "flag" is real.

Flag format:
CTF{...}
EOF
