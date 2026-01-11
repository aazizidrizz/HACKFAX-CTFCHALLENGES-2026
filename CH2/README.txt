#!/bin/bash
cat <<'EOF'
Challenge: Proposal Equation (Hard)

Cupid tore the equation apart.

Goal:
1) Rebuild the equation values A, B, and C from the files
2) Solve for x in: (A * x) + B = C
3) Decode the final message to reveal the flag

Rules:
- Flag format: CTF{...}

Hints:
- Use grep/awk/sed and bc
- One encoded file is a decoy
- Decoding involves turning numbers into characters
EOF
