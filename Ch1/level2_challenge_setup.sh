#!/bin/bash
set -euo pipefail

echo "[*] Setting up CTF Level 2 (Hidden Valentine – harder)..."

LEVEL_DIR="/home/student/CTF_Challenges/level2"

FLAG="CTF{Love_Hides_Between_Lines}"
FAKE_FLAG="CTF{Love_Is_Obvious}"

# Create directory
mkdir -p "$LEVEL_DIR" || { echo "Failed to create directory"; exit 1; }
cd "$LEVEL_DIR" || { echo "Failed to access directory"; exit 1; }

# Clean old run
rm -rf .letters poem.txt letter*.txt roses.txt chocolate.txt hiddenfile.txt 2>/dev/null || true

# Decoy files
touch letter1.txt letter2.txt roses.txt chocolate.txt

# Poem with a directional clue
cat > poem.txt <<'EOF'
Some words are spoken,
Some are concealed.
Not every letter is sent,
Some remain in drafts.
EOF

# Fake flag
echo "$FAKE_FLAG" > hiddenfile.txt

# Hidden directories
mkdir -p .letters/.drafts

# Real flag (not obvious filename)
echo "$FLAG" > .letters/.drafts/valentine.txt

# Permissions
chmod -R 755 .letters
chmod 644 .letters/.drafts/valentine.txt poem.txt hiddenfile.txt
chmod 644 letter1.txt letter2.txt roses.txt chocolate.txt

