#!/bin/bash
cat <<'EOF'
Challenge: Proposal_Equation (Hard) — Kali Linux

Cupid was nervous and tore apart a proposal equation. The pieces are scattered across notes.
Your job is to rebuild the equation, solve for x, and use it to find the one real love letter
hidden among many decoys.

Goal:
1) Extract A, B, and C from the notes.
2) Solve for x in: (A * x) + B = C
3) Use x to pick the correct box:
   boxes/<x>/encoded_love.txt
4) Decode the numbers in encoded_love.txt into readable text to get the flag.

Rules:
- Flag format: CTF{...}
- Do not brute force all boxes. Solve the equation to find the correct one.
- This is a Linux CLI challenge: use tools like grep, awk, cut, tr, bc, cat, ls, cd.

Hints (if needed):
- B may include spaces around the '=' sign.
- x should be a whole number.
- The encoded message is a list of decimal ASCII values.

Good luck — and may your math lead to true love.
EOF
