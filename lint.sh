#!/bin/bash
# lint.sh — Run all linters locally (same checks as GitHub Actions)
# Usage: ./lint.sh          → check only
#        ./lint.sh --fix    → auto-fix what's possible

set -uo pipefail

FIX_MODE=false
[[ "${1:-}" == "--fix" ]] && FIX_MODE=true

ERRORS=0
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_ROOT" || exit 1

# ─── Colors ───
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

pass() { echo -e "  ${GREEN}✓${NC} $1"; }
fail() { echo -e "  ${RED}✗${NC} $1"; ERRORS=$((ERRORS + 1)); }
info() { echo -e "${CYAN}━━━ $1 ━━━${NC}"; }

# ─── 1. Markdown ───
info "Markdown Lint"
if command -v markdownlint-cli2 &>/dev/null; then
    if $FIX_MODE; then
        if markdownlint-cli2 --fix '**/*.md' 2>&1; then
            pass "Markdown: auto-fixed"
        else
            fail "Markdown: some issues remain after fix (see above)"
        fi
    else
        if markdownlint-cli2 '**/*.md' 2>&1; then
            pass "Markdown: clean"
        else
            fail "Markdown: issues found (run with --fix to auto-fix)"
        fi
    fi
else
    fail "markdownlint-cli2 not found (npm install -g markdownlint-cli2)"
fi

# ─── 2. YAML ───
info "YAML Lint"
if command -v yamllint &>/dev/null; then
    if yamllint -c .yamllint.yml . 2>&1; then
        pass "YAML: clean"
    else
        fail "YAML: issues found"
    fi
else
    fail "yamllint not found (brew install yamllint)"
fi

# ─── 3. ShellCheck ───
info "ShellCheck"
if command -v shellcheck &>/dev/null; then
    SHELL_ERRORS=0
    while IFS= read -r -d '' file; do
        # Strip chezmoi template directives before checking
        CLEANED=$(sed 's/{{.*}}//g' "$file")
        if ! echo "$CLEANED" | shellcheck -s bash - 2>&1 | grep -v "^$"; then
            : # clean
        else
            SHELL_ERRORS=$((SHELL_ERRORS + 1))
        fi
    done < <(find . -not -path './.git/*' \( -name '*.sh' -o -name '*.sh.tmpl' \) -print0)

    if [[ $SHELL_ERRORS -eq 0 ]]; then
        pass "ShellCheck: clean"
    else
        fail "ShellCheck: $SHELL_ERRORS file(s) with issues"
    fi
else
    fail "shellcheck not found (brew install shellcheck)"
fi

# ─── 4. EditorConfig ───
info "EditorConfig"
if command -v editorconfig-checker &>/dev/null; then
    if editorconfig-checker 2>&1; then
        pass "EditorConfig: clean"
    else
        fail "EditorConfig: issues found"
    fi
else
    # Also check for the 'ec' alias (some installs use this)
    if command -v ec &>/dev/null; then
        if ec 2>&1; then
            pass "EditorConfig: clean"
        else
            fail "EditorConfig: issues found"
        fi
    else
        fail "editorconfig-checker not found (brew install editorconfig-checker)"
    fi
fi

# ─── 5. Zsh syntax ───
info "Zsh Syntax"
if command -v zsh &>/dev/null; then
    ZSH_ERRORS=0
    for f in dot_zshenv dot_config/zsh/*.zsh dot_config/zsh/dot_zshrc; do
        if [[ -f "$f" ]]; then
            if ! zsh -n "$f" 2>&1; then
                ZSH_ERRORS=$((ZSH_ERRORS + 1))
            fi
        fi
    done
    if [[ $ZSH_ERRORS -eq 0 ]]; then
        pass "Zsh syntax: clean"
    else
        fail "Zsh syntax: $ZSH_ERRORS file(s) with issues"
    fi
else
    fail "zsh not found"
fi

# ─── Summary ───
echo ""
if [[ $ERRORS -eq 0 ]]; then
    echo -e "${GREEN}══════════════════════════════${NC}"
    echo -e "${GREEN}  All checks passed! 🎉${NC}"
    echo -e "${GREEN}══════════════════════════════${NC}"
    exit 0
else
    echo -e "${RED}══════════════════════════════${NC}"
    echo -e "${RED}  $ERRORS check(s) failed${NC}"
    echo -e "${RED}══════════════════════════════${NC}"
    exit 1
fi
