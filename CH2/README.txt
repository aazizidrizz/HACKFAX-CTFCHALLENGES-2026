#!/bin/bash
cat <<'EOF'
Challenge: Proposal Equation (Hard)

Cupid tore the equation apart.

Goal:
1) Rebuild A, B, and C from the files
2) Solve for x in: (A * x) + B = C
3) Use x to locate the correct encoded file: encoded_<x>.txt
4) Decode that file (numbers -> characters) to reveal the flag

Hints:
- Use grep/awk/cut/tr and bc
- There are MANY encoded_XX.txt files
- Only the one matching x contains the real flag
EOF
