#!/bin/bash

# Ghostty Feature Verification Script

# 1. Check TERM variable
echo "--- Terminal Identity ---"
if [[ "$TERM" == "xterm-ghostty" ]]; then
    echo -e "✅ TERM is set to: $TERM"
else
    echo -e "❌ TERM is set to: $TERM (Expected: xterm-ghostty)"
    echo -e "   Hint: Try 'export TERM=xterm-ghostty' before running tests."
fi

echo -e "\n--- 24-bit True Color Test ---"
# Renders a smooth RGB gradient
awk 'BEGIN{
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76); g = (colnum*510/76); b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm ", r,g,b;
    }
    printf "\033[0m\n";
}'
echo "Check: Is the bar above a smooth rainbow gradient?"

echo -e "\n--- Undercurl & Underline Color Test ---"
# Standard Underline
printf "\e[4mStandard Underline\e[0m\n"
# Undercurl (Smulx)
printf "\e[4:3mCurly Underline (Undercurl)\e[0m\n"
# Colored Undercurl
printf "\e[4:3m\e[58:2:255:0:0mRed Colored Undercurl\e[0m\n"

echo -e "\n--- System Terminfo Location ---"
TERMINFO_PATH=$(infocmp -x xterm-ghostty 2>/dev/null | head -n 1 | grep -o '/.*')
if [ -n "$TERMINFO_PATH" ]; then
    echo "Found definition at: $TERMINFO_PATH"
else
    echo "❌ Could not find xterm-ghostty in terminfo database."
fi

echo -e "\nTest Complete."
