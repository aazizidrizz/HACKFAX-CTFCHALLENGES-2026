#!/bin/bash
set -euo pipefail

CHAL="proposal_equation"

# Use the current user's home directory
BASE="$HOME/CTF_Challenges"
DIR="$BASE/$CHAL"
BOXDIR="$DIR/boxes"

# --- Pre-flight checks (prevents confusing permission errors) ---
mkdir -p "$BASE" 2>/dev/null || {
  echo "[!] ERROR: Cannot create $BASE"
  echo "    Fix: sudo chown -R $USER:$USER \"$HOME\"/CTF_Challenges  (or choose another base path)"
  exit 1
}

# If the directory exists but isn't writable, fail clearly
if [[ -e "$DIR" && ! -w "$DIR" ]]; then
  echo "[!] ERROR: $DIR exists but is not writable by $USER."
  echo "    Likely cause: it was created by sudo/root earlier."
  echo "    Fix: sudo chown -R $USER:$USER \"$DIR\""
  exit 1
fi

mkdir -p "$DIR" "$BOXDIR" || {
  echo "[!] ERROR: Cannot create challenge directories under $BASE"
  exit 1
}

# --- Stable math values (so it's predictable for testing) ---
# If you want random later, tell me and I'll add safe randomization.
x=42
A=3
B=7
C=$((A * x + B))

FLAG="CTF{TRUE_LOVE_EQUALS_${x}}"

# --- Clue files ---
cat > "$DIR/cupid_note.txt" <<'EOF'
Dear contestant,

Cupid tore the equation apart.
He remembers only this:

( A * x ) + B = C

Find A, B, and C from the other notes,
then solve for x.

Once you find x, Cupid hid the real message in:
boxes/<x>/encoded_love.txt

- Cupid
EOF

cat > "$DIR/roses_and_math.txt" <<EOF
roses=red
violets=blue
A=$A
chocolate=sweet
EOF

cat > "$DIR/dinner_receipt.txt" <<EOF
Date Night Receipt
-----------------
dessert ............ 7
B = $B
Total: $C
C=$C
EOF

cat > "$DIR/hint.txt" <<'EOF'
There are many boxes.
Each box contains a file with the SAME name: encoded_love.txt
Only the box number you solve for (x) contains the real flag.
EOF

# --- Create boxes 01..99, each with encoded_love.txt ---
# Use umask so files are readable without needing chmod
umask 022

for i in $(seq -w 1 99); do
  mkdir -p "$BOXDIR/$i"
  msg="DECOY{HEARTS_AND_LIES_$i}"
  echo -n "$msg" | od -An -tu1 | sed 's/^ *//' > "$BOXDIR/$i/encoded_love.txt"
done

# Overwrite the real one
REALFOLDER=$(printf "%02d" "$x")
echo -n "$FLAG" | od -An -tu1 | sed 's/^ *//' > "$BOXDIR/$REALFOLDER/encoded_love.txt"

echo "[+] Installed $CHAL at $DIR"
echo "[+] Start here: cd \"$DIR\""
