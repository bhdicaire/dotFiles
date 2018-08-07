all :	     help
update:	     banner git bash editorconfig tmux ssh

###############################################################################

programName       := dotFiles
programVersion    := 0.5
programSource     := https://github.com/bhdicaire/dotFiles
modifiedBy        := BH Dicaire — Code@BHDicaire.com

SHELL             := /bin/bash
RM                := /bin/rm -f
GIT               := /usr/local/bin/git
makeLocation      := `which make`
makeVersion       := `make -v|grep GNU`
gitLocation        := `which git`
gitVersion         := `git --version`
dateStamp         := $(shell date "+%Y%m%d")

normalText        := "\033[0m"
boldText          := "\033[1m"
italicText        := "\033[3m"
tab               := "\t"
2tab              := "\t\t"
tabNormal         := $(tab)$(normalText)
tabBold           := $(tab)$(boldText)

buildDir          := /.dotFiles
gitRepository     := https://github.com/bhdicaire/dotFiles
dotFiles          := $(GIT) --git-dir=$(HOME)$(buildDir) --work-tree=$(HOME)/

#############################################################################

vim:
	@echo -e  $(boldText)"\n\n##########" $(tab)Commit VIM$(tabNormal)"\n"
	@cp ~/.vimrc .
	@$(GIT) add .vimrc
	@$(GIT) commit -m"Add vim configuration"
	@$(GIT) push
	@printf "\n\n"

git:
	@echo -e  $(boldText)"\n\n##########" $(tab)Commit VIM$(tabNormal)"\n"
	@cp ~/.git* .
	@$(GIT) add .git*
	@$(GIT) commit -m"Add Git configuration"
	@$(GIT) push
	@printf "\n\n"

bash:
	@echo -e  $(boldText)"\n\n##########" $(tab)Commit BASH$(tabNormal)"\n"
	@cp ~/.bash_profile .
	@cp ~/.bashrc* .
	@git add .bash*
	@git commit -m"Update bash configuration"
	@$(GIT) push
	@printf "\n\n"

editorconfig:
	@echo -e  $(boldText)"\n\n##########" $(tab)Commit VIM$(tabNormal)"\n"
	@cp ~/.editorconfig .
	@$(GIT) add .editorconfig
	@$(GIT) commit -m"Add editorconfig"
	@$(GIT) push
	@printf "\n\n"

tmux:
	@echo -e  $(boldText)"\n\n##########" $(tab)Commit TMUX$(tabNormal)"\n"
	@cp ~/.tmux* .
	@$(GIT) add .tmux*
	@$(GIT) commit -m"Add TMUX configuration"
	@$(GIT) push
	@printf "\n\n"

ssh:
	@echo -e  $(boldText)"\n\n##########" $(tab)Commit SSH$(tabNormal)"\n"
	mkdir -p .ssh
	cp ~/.ssh/config .ssh
	cp ~/.ssh/sshConfig* .ssh
	$(GIT) add .ssh/config .ssh/sshConfig*
	$(GIT) commit -m"Add SSH configuration"
	$(GIT) push
	@printf "\n\n"

banner:
	@printf "\n\n"
	@echo -e $(normalText)
	@printf "###################################################################################################\n\n"
	@echo -e "\t$(programName) — v$(programVersion)" $(italicText)"with" $(normalText)"$(makeVersion) [$(makeLocation)]\n"
	@echo -e "\tsource:\t\t$(programSource)"
	@printf "\tmodified by:\t$(modifiedBy)\n\n"
	@printf "###################################################################################################\n\n"

help:
	@$(MAKE) banner
	@echo -e $(boldText)"\n\tTarget\t\tFunction\n"$(normalText)

	@printf "\ttest\t\tRead configuration and identify changes to be made, without applying them\n"
	@printf "\tdebug\t\tRun test above and check configuration\n"
	@printf "\tbuild\t\tDeploy configuration to DNS servers\n"
	@printf "\tpush\t\tBuild above and commit changes to Git, you may use msg=abc or ticket=123\n"
	@printf "\tarchive\t\tBuild above, copy configuration to archive subfolder, and commit to Git\n"
	@printf "\tclean\t\tDelete dnsConfig.json and archive subfolder\n"
	@printf "\thelp\t\tThis information\n"
	@printf "\n\n"

setup:
	@$(MAKE) banner
	@$(GIT) init --bare $(HOME)${buildDir}
	@$(GIT) config --local status.showUntrackedFiles no
	@$(GIT) status
