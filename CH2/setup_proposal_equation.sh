#!/bin/bash
set -e

CHAL="proposal_equation"
DIR="/home/student/CTF_Challenges/$CHAL"
BOXDIR="$DIR/boxes"

mkdir -p "$DIR" "$BOXDIR"

x=42

A=3
B=7
C=$(( A * x + B ))

FLAG="CTF{TRUE_LOVE_EQUALS_${x}}"

# ----------------------------
# 2) Create clue files
# ----------------------------
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

# ----------------------------
# 3) Create boxes 01..99, each with "encoded_love.txt"
#    Only boxes/<x>/encoded_love.txt contains the real flag
# ----------------------------
for i in $(seq -w 1 99); do
  mkdir -p "$BOXDIR/$i"
  msg="DECOY{HEARTS_AND_LIES_$i}"
  echo -n "$msg" | od -An -tu1 | sed 's/^ *//' > "$BOXDIR/$i/encoded_love.txt"
done

# Overwrite the real one
REALFOLDER=$(printf "%02d" "$x")
echo -n "$FLAG" | od -An -tu1 | sed 's/^ *//' > "$BOXDIR/$REALFOLDER/encoded_love.txt"

chmod -R 644 "$DIR"
find "$BOXDIR" -type d -exec chmod 755 {} \;

echo "[+] Installed $CHAL at $DIR"
echo "[+] (Admin note) Real path: $BOXDIR/$REALFOLDER/encoded_love.txt"
