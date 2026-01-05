#!/bin/bash
set -euo pipefail

echo "[*] Setting up CTF Level 2 challenge files..."

LEVEL_DIR="/home/student/CTF_Challenges/level2"

FLAG="CTF{Love_Hides_In_Dotfiles}"
FAKE_FLAG="CTF{Love_Hides_In_Plain_Sight}"

# Create directory
mkdir -p "$LEVEL_DIR" || { echo "Failed to create directory"; exit 1; }
cd "$LEVEL_DIR" || { echo "Failed to access directory"; exit 1; }

# Clean old run (challenge files only)
rm -f .valentine_note.txt hiddenfile.txt poem.txt letter*.txt roses.txt chocolate.txt 2>/dev/null || true

# Decoy files
touch letter1.txt letter2.txt roses.txt chocolate.txt

cat > poem.txt <<'EOF'
Roses are red,
Violets are blue,
Some things are unseen,
Until you know what to do.
EOF

# Fake flag (decoy)
echo "$FAKE_FLAG" > hiddenfile.txt

# Real flag (hidden dotfile)
echo "$FLAG" > .valentine_note.txt

# Permissions
chmod 644 poem.txt hiddenfile.txt .valentine_note.txt
chmod 644 letter1.txt letter2.txt roses.txt chocolate.txt

# Ownership (optional; ignore errors if not allowed)
chown -R "$(whoami)":"$(whoami)" "$LEVEL_DIR" 2>/dev/null || true

echo "[+] Challenge files created at: $LEVEL_DIR"
echo "[+] (Dev) Real flag: $FLAG"
