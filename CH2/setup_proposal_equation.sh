#!/bin/bash
set -e

CHAL="proposal_equation"
DIR="/home/student/CTF_Challenges/$CHAL"
FLAG="CTF{TRUE_LOVE_EQUALS_42}"

mkdir -p "$DIR"

# File 1: tells the equation structure
cat > "$DIR/cupid_note.txt" <<'EOF'
Dear contestant,

Cupid got nervous and tore the equation apart.
He remembers only this:

( A * x ) + B = C

Find A, B, and C from the other love notes.

- Cupid
EOF

# File 2: contains A hidden in normal-looking "data"
cat > "$DIR/roses_and_math.txt" <<'EOF'
roses=red
violets=blue
A=3
chocolate=sweet
EOF

# File 3: contains B and C mixed into a receipt with noise
cat > "$DIR/dinner_receipt.txt" <<'EOF'
Date Night Receipt
-----------------
appetizer .......... 11
dessert ............  7
B = 7
candles ............  5
Total: 133
C=133
EOF

# File 4: real flag encoded as decimal ASCII values
echo -n "$FLAG" | od -An -tu1 | sed 's/^ *//' > "$DIR/encoded_love.txt"

# Decoy encoded file (to increase difficulty)
echo -n "CTF{NOT_THIS_ONE}" | od -An -tu1 | sed 's/^ *//' > "$DIR/encoded_decoy.txt"

# Small hint that doesn't give away exact commands
cat > "$DIR/hint.txt" <<'EOF'
True love is consistent.
If you find A, B, and C, you can solve for x.
Once you have x, the rest should "convert" nicely.
EOF

chmod 644 "$DIR"/*
echo "[+] Installed $CHAL at $DIR"
