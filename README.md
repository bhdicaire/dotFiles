# ![Logo](.github/header.png "Logo")

![GitHub Stars](https://img.shields.io/github/stars/bhdicaire/dotFiles?style=flat-square&logoColor=186ADE&labelColor=3E5462&color=00A1E8)
![GitHub forks](https://img.shields.io/github/forks/bhdicaire/dotFiles?style=flat-square&logoColor=186ADE&labelColor=3E5462&color=00A1E8)
![GitHub release](https://img.shields.io/github/v/release/bhdicaire/dotFiles?style=flat-square&logoColor=186ADE&labelColor=3E5462&color=00A1E8)
![GitHub Last Commit](https://img.shields.io/github/last-commit/bhdicaire/dotFiles?style=flat-square&logoColor=186ADE&labelColor=3E5462&color=00A1E8)
![Lint](https://img.shields.io/github/actions/workflow/status/bhdicaire/dotFiles/lint.yml?style=flat-square&label=lint&logoColor=186ADE&labelColor=3E5462&color=00A1E8)
![GitHub licence](https://img.shields.io/github/license/bhdicaire/dotFiles?style=flat-square&logoColor=186ADE&labelColor=3E5462&color=00A1E8)
![shell-zsh](https://img.shields.io/badge/shell-zsh-00A1E8)
![chezmoi](https://img.shields.io/badge/managed%20by-chezmoi-00A1E8)
![prompt-starship](https://img.shields.io/badge/prompt-starship-00A1E8)

Your dotFiles should be unique. These are mine, fork this repository as a reference. You can learn a lot by looking at how other people set up their dotfiles.

This repository managed with [Chezmoi](https://www.chezmoi.io/), is the configuration for my Debian-based headless servers.

## 💎 Key Features

<details>
<summary>📂 Secure, templated dotfile management</summary>

This repository uses [Chezmoi](https://www.chezmoi.io/) templates. Check the other sections.

When you install it, your identity is stored in `~/.config/chezmoi/chezmoi.toml`. You can manually update these values by running: `chezmoi edit-config`.

Many dot files are managed by [Chezmoi](https://www.chezmoi.io/)

* `dot_curlrc`: [Curl](https://curl.se/) is used in command lines or scripts to transfer data
* `dot_editorconfig`: [EditorConfig](https://editorconfig.org/) a file format that enable various text editors and IDEs to adhere to defined styles
* `dot_tmux.conf`: [tmux](https://github.com/tmux/tmux/wiki) is a terminal multiplexer. It lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal
* `dot_wgetrc`: [GNU Wget](https://www.gnu.org/software/wget/) is a non-interactive commandline tool for retrieving files using HTTP, HTTPS, FTP and FTPS

> The reason that many of these file names start with a period and are therefore known as “dotfiles” is the accidental invention of [“hidden files” in 1997](https://linux-audit.com/linux-history-how-dot-files-became-hidden-files/).
</details>
<details>
<summary>🧩 Modular Zsh configuration with aliases and functions</summary>

[Zsh](https://www.zsh.org/) is a shell designed for interactive use, the files load order:

1. `~/.zshenv` managed as dot_zshenv
    * Environment variables loaded for all shells such as interactive, non-interactive, login, and scripts
2. `~/.config/zsh/.zshrc` managed as dot_config/zsh/dot_zshrc
    * Main config file for interactive shells
3. `~/.config/zsh/aliases.zsh` managed as dot_config/zsh/aliases.zsh
    * Additional configuration loaded via `.zshrc`
4. `~/.config/zsh/functions.zsh` managed as dot_config/zsh/functions.zsh
    * Additional configuration loaded via `.zshrc`
5. `~/.config/starship.toml` managed as dot_config/starship.toml
    * [Starship prompt](https://starship.rs/) loaded via `.zshrc`

Install zsh manually if you're not using `run_once_before_install-packages.sh.tmpl`

1. `sudo apt install zsh`
2. `chsh -s /bin/zsh`

The change takes effect on your next login (or open a new terminal session) and verify with `echo $SHELL`
</details>
<details>
<summary>🛠 Modern Tooling</summary>

* Standard `ls` is aliased to [Eza](https://eza.rocks/) for better readability:
  * `--icons`: Display of icons for different file types with a [Nerd Font](https://www.nerdfonts.com/)
  * `--git`: Shows Git status for files directly in the directory listing
  * `--group-directories-first`: Keeps your view organized
* Prompt: [Starship](https://starship.rs/) is gorgeous and works everywhere with Rust-powered
* System info: [Fastfetch](https://github.com/fastfetch-cli/fastfetch) is a maintained neofetch like tool

</details>

<details>
<summary>🔒 Hardened GIT & SSH configuration</summary>

Commit Signing: Git is configured to sign commits using SSH keys (ED25519)

* [GitHub](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification) & [GitLab] (https://docs.gitlab.com/user/project/repository/signed_commits/ssh/) documentation

Multiplexing: Hardened ~/.ssh/config with ControlMaster enabled for lightning-fast subsequent connections to the same host

Privacy: Sensitive hostnames and IPs are offloaded to ~/.ssh/config.local (ignored by Git)

Modular [GIT](https://git-scm.com/) configuration:

* `~/.config/git/config` managed as a Chezmoi's template `/dot_config/config.tmpl`
  * Main config file, template information are collected during the quick start
* `~/.config/git/aliases` managed as `/dot_config/aliases`
  * Additional configuration loaded via `~/.config/git/config`
* `~/.config/git/gitignore_global` managed as `/dot_config/gitignore_global`
  * Used by GIT without a specific configuration

Modular [SSH](https://www.openssh.org/) configuration:

* `~/.ssh/config` managed as a Chezmoi's template `dot_ssh/config.tmpl`
  * Main config file, template information are collected during the quick start
* `~/.ssh/authorized_keys` managed as a Chezmoi's template `dot_ssh/authorized_keys.tmpl`
  * Contains a list of public keys that are permitted to access that specific user account remotely
  * Include one static key and keys fetched from GitHub
* `~/.ssh/sockets` managed as `dot_ssh/sockets`
  * Support Multiplexing for lightning-fast subsequent connections to the same host

</details>

<details>
<summary>✍️ Vim configuration with colors cheme support</summary>

[Configured](https://github.com/bhdicaire/dotFiles/blob/main/dot_vimrc) for professional sysadmin work:

* Mac classic color scheme [modified by Drew Neil](https://github.com/altercation/vim-colors-solarized) for a clean, light-background aesthetic
* Support for termguicolors, optimized for [Ghostty](https://ghostty.org/)
* Swaps and backups disabled to keep your home directory clean

</details>

## 🚀 Quick Start

On a fresh Debian install, run:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply bhdicaire
```

① Installs [Chezmoi](https://www.chezmoi.io/) to manage your dotFiles

② Automatically triggers the [run_once_before_install-packages.sh](https://github.com/bhdicaire/dotFiles/blob/main/run_once_before_install-packages.sh.tmpl) script to install missing components

③ Prompts you for information in order to generate localized configs

* Email for GIT configuration
* Full name for GIT signature
* Hostname for specific configuration items

```text
.
├── dot_config/
│   ├── git/          # Templated Git config (name/email)
│   ├── zsh/          # Modular shell scripts (aliases.zsh, functions.zsh)
│   └── starship.toml # Prompt configuration
├── dot_ssh/
│   ├── config.tmpl   # Secure SSH client config
│   └── authorized_keys.tmpl # Fetches keys from GitHub
├── dot_vim/          # Vim colorschemes
├── dot_vimrc         # Main Vim configuration
└── run_once_before_install-packages.sh.tmpl #  Bootstrap script
```

## Licence

dotFiles by Benoît H. Dicaire are shared under [MIT](https://github.com/bhdicaire/dotFiles/raw/master/LICENSE).

## Related projects

* [The *unofficial** guide to dotfiles on GitHub](https://dotfiles.github.io/)
* [Awesome dotfiles](https://github.com/webpro/awesome-dotfiles)
