#!/bin/bash
set -euo pipefail

############################
# Configuration
############################
CHAL="proposal_equation"
BASE="$HOME/CTF_Challenges"
DIR="$BASE/$CHAL"
BOXDIR="$DIR/boxes"

# Stable math values (easy to test, change later if desired)
x=42
A=3
B=7
C=$((A * x + B))

FLAG="CTF{TRUE_LOVE_EQUALS_${x}}"

############################
# Pre-flight checks
############################
mkdir -p "$BASE"

if [[ ! -w "$BASE" ]]; then
  echo "[!] ERROR: $BASE is not writable by $USER"
  echo "Fix: sudo chown -R $USER:$USER \"$BASE\""
  exit 1
fi

############################
# Create directories
############################
mkdir -p "$DIR" "$BOXDIR"

############################
# Clue files
############################
cat > "$DIR/cupid_note.txt" <<'EOF'
Dear contestant,

Cupid tore the equation apart.
He remembers only this:

( A * x ) + B = C

Find A, B, and C from the other notes.
Solve for x.

Once you find x, the real message is in:
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
Each box contains a file named encoded_love.txt.
Only the box number you solve for (x) contains the real flag.
EOF

############################
# Create decoy boxes
############################
umask 022

for i in $(seq -w 1 99); do
  mkdir -p "$BOXDIR/$i"
  msg="DECOY{HEARTS_AND_LIES_$i}"
  echo -n "$msg" | od -An -tu1 | sed 's/^ *//' > "$BOXDIR/$i/encoded_love.txt"
done

############################
# Insert real flag
############################
REALBOX=$(printf "%02d" "$x")
echo -n "$FLAG" | od -An -tu1 | sed 's/^ *//' > "$BOXDIR/$REALBOX/encoded_love.txt"

############################
# SAFE permissions block
# (this is the part that prevents future breakage)
############################
find "$DIR" -type d -exec chmod 755 {} \;
find "$DIR" -type f -exec chmod 644 {} \;

############################
# Done
############################
echo "[+] Challenge installed safely at:"
echo "    $DIR"
echo "[+] Start here:"
echo "    cd \"$DIR\""
