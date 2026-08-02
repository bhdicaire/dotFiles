# CLAUDE.md — dotFiles

This file is read by Claude Code at the start of every session in this repo. It governs
`bhdicaire/dotFiles` (public) and, by reference, `bhdicaire/dotFilesPrivate`.

## What this repo is

The chezmoi source for Benoit's dotfiles, applied across his machines: `dogbert`
(MacBook Pro, workstation profile) and `mi6` (Mac mini, orchestrator profile), managed
alongside `mac-setupv2` (a separate Ansible project — see its own CLAUDE.md for the
division of labor: mac-setupv2 owns software installation and machine-level config,
this repo owns dotfiles).

## Two-repo structure (decided, don't relitigate)

- **`dotFiles`** (this repo, public) — generic, shareable config only. Shell rc files,
  editor config, git aliases, tool configs under `~/.config` that contain no
  host-topology or business-context information. This is the primary chezmoi source
  (`chezmoi init bhdicaire/dotFiles`).
- **`dotFilesPrivate`** (private repo, created at `/Volumes/Tarmac/code/dotFilesPrivate`,
  linked to GitHub) — anything host-topology-specific (UniFi/Proxmox
  references, SSH host aliases revealing homelab structure — `pve-01`, `pve-02`, etc.)
  or Alcatraz/business-context-specific. Pulled into this repo's target tree via
  `.chezmoiexternal.toml` (`type = "git-repo"`), not via a second `chezmoi init`.
- Files in `dotFilesPrivate` use chezmoi's built-in age encryption in **passphrase
  mode** (`age -p`, scrypt + ChaCha20-Poly1305), not recipient/public-key mode — this
  avoids the elliptic-curve key exchange that recipient mode relies on. Filenames get
  the `encrypted_` prefix per chezmoi convention.
- The encryption passphrase is a 1Password secret in the `homeLab-automation` vault,
  retrieved via `op read` at bootstrap and fed to chezmoi's config
  (`.chezmoi.toml.tmpl` → `encryption.age.passphrase` or equivalent env var at apply
  time). **Do not generate this passphrase yourself.** Ask Benoit to create the
  1Password item and give you the reference path
  (`op://homeLab-automation/<item name>/<field>`) — you configure chezmoi to read it,
  you never see or choose the value.
- No secret/credential values belong in either repo regardless of encryption — secrets
  are resolved via 1Password templating (`onepassword` chezmoi template functions).
  Encryption on the private repo is a second, independent layer protecting
  topology/context information, not a place to relax the "no secrets" rule.

## Non-negotiable rules

1. **No secrets in either repo, ever** — same rule as mac-setupv2. If you find one
   during cleanup, stop, don't copy the value anywhere, report the file path and what
   kind of credential it looks like, and wait for it to be moved to 1Password before
   touching that file further.
2. **Classify before moving anything.** For every file currently in `dotFiles`, decide:
   stays public as-is / moves to `dotFilesPrivate` as-is / needs secret extraction
   before it can go anywhere. Don't move files in bulk without this per-file pass —
   that's how a genuinely public-safe file ends up needlessly encrypted, or worse,
   how a sensitive one gets missed and stays public.
3. **Test on Dogbert only, not mi6, for this cleanup.** mi6's own chezmoi
   application is mac-setupv2's concern (its `common` role invokes chezmoi) and
   depends on this repo restructuring being finished and stable first. Use
   `chezmoi diff` and `chezmoi apply --dry-run` on Dogbert to validate before any
   real `chezmoi apply`.
4. **This session runs in parallel with a separate mac-setupv2 Claude Code session.**
   Don't touch anything under the mac-setupv2 working directory. If you find you need
   something from that project (e.g. confirming the `homeLab-automation` vault name
   or the exact 1Password item Benoit created), ask directly rather than reading files
   from that other project's directory.

## Sequence for this cleanup

1. Inventory every file currently tracked by chezmoi in this repo (`chezmoi managed`
   run against the current source, or a plain review of the repo tree if not yet
   applied anywhere) and produce the classification table described in rule 2.
2. Flag anything secret-shaped per rule 1 before doing anything else with those files.
3. `dotFilesPrivate` already exists at `/Volumes/Tarmac/code/dotFilesPrivate` and is
   linked to GitHub — confirm you can see it locally before proceeding, don't create
   a new one.
4. Move classified-private files into the private repo structure, apply `encrypted_`
   prefixing, and set up `.chezmoiexternal.toml` in this repo pointing at it.
5. Validate with `chezmoi diff` / `chezmoi apply --dry-run` on Dogbert.
6. Update this file's classification table (add it below, or as `docs/CLASSIFICATION.md`)
   so the decision trail isn't lost.

## Model guidance

Sonnet 5 (default) — this is largely mechanical classification and restructuring
against an already-decided shape, not novel architecture. Escalate to Opus 4.8 only if
a specific file's public/private classification is genuinely ambiguous and the call
matters (e.g., something that's arguably generic but references a real hostname or
path you're not sure is sensitive) — surface those individually rather than guessing.
