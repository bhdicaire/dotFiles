![alt text](https://github.com/bhdicaire/dotFiles/raw/master/logo.png "Logo")

This repository is used to centralise my dotfiles for Bash (Linux & macOS) and a local bin folder for executables. allowing you to use the same settings on all your machines.

Backup, restore, and sync the prefs and settings for your toolbox. Your dotfiles might be the most important files on your machine.

For a lot of us, a big chunk of our dotFiles is devoted to our configurations  and our text editor. 

Your dotFiles should be unique. These are mine. Fork this repository so you can see how each file is structured and it’s content. 

Unix command-line programs are usually configured using plain-text hidden files1, commonly referred to as dotfiles, that are stored in the user’s home directory. For developers who spend any amount of time in the terminal, tweaking and optimizing settings for command-line programs can be an extremely worthwhile investment. Something as easy as light shell customization can result in a significant increase in productivity.

Looking around the Internet, many individuals have open sourced their dotfiles for others to see. A quick GitHub search returns tens of thousands of results. Does this mean that you should run a quick git clone and be off and running someone’s awesome dotfiles? No.

## Getting started with VisualAssets

Beware you probably already have a .bash_profile and .gitconfig in the user folder. So please be careful here. With great power comes great responsibility. Probably it’s best to backup important files before you’re moving them around.

computer in the world. That’s why it is a good idea to keep them in a distributable way, so that you can import them easily when you migrate to another system.
DonÉ't forget to update your .giignore ...

There are two main approaches for using a VCS to keep track of configuration files: you can have your entire home directory under version control (and ignore non-configuration files), or you can keep your configuration files in a separate directory and copy or link them into place. 

passwords/API keys/other sensitive data
dotfiles are the personality of your computer. Without them, it would be like any other computer in the world. That’s why it is a good idea to keep them in a distributable way, so that you can import them easily when you migrate to another system.

But dotfiles have a well-know problem when it comes to make them distributable: they are all scattered in your home directory, so it makes difficult to create repositories from them.

As far as I know, there are two main tools that help us with it:

scripts to set up his computer from scratch, installing all of his packages and setting up his environment.

### Local overrisde

If you’re using a different shell, you probably want to name the file differently.

Git
You can add the following to the end of your .gitconfig file to enable overriding:

[include]
        path = ~/.gitconfig_local
Vim
You can add the following to the end of your .vimrc file to enable overriding:

let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
tmux
You can add the following to the end of your .tmux.conf file to enable overriding4:

if-shell "[ -f ~/.tmux_local.conf ]" 'source ~/.tmux_local.conf'

bash instructions
Copy gibo-completion.bash into a bash_completion.d folder:

/etc/bash_completion.d
/usr/local/etc/bash_completion.d
~/bash_completion.d
or copy it somewhere (e.g. ~/.gibo-completion.bash) and put the following in your .bashrc:

source ~/.gibo-completion.bash

No extra tooling, no symlinks, files are tracked on a version control system, you can use different branches for different computers, you can replicate you configuration easily on new installation.

https://bitbucket.org/durdn/cfg
https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
## Structure

.
├── git
│ ├── .gitconfig
│ └── .gitignore_global
├── install.sh
├── osxdefaults.sh
├── runcom
│ ├── .bash_profile
│ └── .inputrc
└── system
 ├── .alias
 ├── .env
 ├── .function
 ├── .path
 └── .prompt

setup an entire macOS environment.

Put your customizations in `~/dotfiles-local` appended with `.local`:

* `~/dotfiles-local/aliases.local`
* `~/dotfiles-local/git_template.local/*`
* `~/dotfiles-local/gitconfig.local`
* `~/dotfiles-local/psqlrc.local` (we supply a blank `.psqlrc.local` to prevent `psql` from
  throwing an error, but you should overwrite the file with your own copy)
* `~/dotfiles-local/tmux.conf.local`
* `~/dotfiles-local/vimrc.local`
* `~/dotfiles-local/vimrc.bundles.local`
* `~/dotfiles-local/zshrc.local`
* `~/dotfiles-local/zsh/configs/*`
Common dotfiles
.zhsrc, .bashrc, .bash_profile, .bash_prompt, etc: These are the configuration files for your shell. From here you can set up aliases (shortcuts), functions, environment variables, and even include other configuration files.
.curlrc, .gvimrc, .vimrc, .wgetrc, etc.: These are configuration files for particular command-line programs. You might be setting font information, default connection information, and more.
.gitattributes, .gitconfig: Global git configuration
.screenrc, .inputrc, .hushlogin: These are files configuring specific aspects of your connection to the shell and/or the terminal.

### Directory Structure

| Folder | Contents |
|----|----|
| `bin` | small utilities|
| `dot` | ww|
| `gitcopfig`| ww |
| `ssh` | ww |

## Licence

The dotFiles by Benoît H. Dicaire are shared under[MIT](https://github.com/bhdicaire/solarized/raw/master/LICENCSE).

## Related projects
https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ 
* [The *unofficial** guide to dotfiles on GitHub](https://dotfiles.github.io/)
* [Awesome dotfiles](https://github.com/webpro/awesome-dotfiles)
