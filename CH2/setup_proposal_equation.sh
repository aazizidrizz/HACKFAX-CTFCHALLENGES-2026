#!/bin/bash
set -e

CHAL="proposal_equation"
DIR="/home/student/CTF_Challenges/$CHAL"

mkdir -p "$DIR"

# ----------------------------
# 1) Generate a random x (the file index)
# ----------------------------
# Keep x in a safe range so we can create encoded_01..encoded_99.
x=$(( (RANDOM % 60) + 20 ))   # x in [20..79]

# Choose A and B, build C = A*x + B (guaranteed integer solution)
A=$(( (RANDOM % 8) + 2 ))     # A in [2..9]
B=$(( (RANDOM % 30) + 5 ))    # B in [5..34]
C=$(( A * x + B ))

FLAG="CTF{MATH_UNLOCKED_LOVE_${x}}"

# ----------------------------
# 2) Create the clue files (A, B, C split across them)
# ----------------------------
cat > "$DIR/cupid_note.txt" <<'EOF'
Dear contestant,

Cupid tore the equation apart.
He remembers only this:

( A * x ) + B = C

Find A, B, and C from the other notes.
Then solve for x.

- Cupid
EOF

# A in a "data" file
cat > "$DIR/roses_and_math.txt" <<EOF
roses=red
violets=blue
chocolate=sweet
A=$A
EOF

# B and C mixed into receipt noise (B has spacing to force parsing skills)
cat > "$DIR/dinner_receipt.txt" <<EOF
Date Night Receipt
-----------------
appetizer .......... 11
dessert ............  7
B = $B
candles ............  5
Total: $C
C=$C
EOF

# Small hint
cat > "$DIR/hint.txt" <<'EOF'
Once you solve for x, use it as a clue.
Cupid labeled the true message with the number you found.
EOF

# ----------------------------
# 3) Create many encoded files; only encoded_<x>.txt is real
# ----------------------------
# We will create encoded_01.txt..encoded_99.txt
# Most decode into harmless decoys. Only encoded_<x>.txt decodes to the real flag.
for i in $(seq -w 1 99); do
  msg="DECOY{LOVE_IS_CONFUSING_$i}"
  echo -n "$msg" | od -An -tu1 | sed 's/^ *//' > "$DIR/encoded_${i}.txt"
done

# Overwrite the correct one with the real flag (and a romantic message)
REALMSG="$FLAG"
echo -n "$REALMSG" | od -An -tu1 | sed 's/^ *//' > "$DIR/encoded_$(printf "%02d" "$x").txt"

chmod 644 "$DIR"/*
echo "[+] Installed $CHAL at $DIR"
echo "[+] (Admin note) Correct file is encoded_$(printf "%02d" "$x").txt"
