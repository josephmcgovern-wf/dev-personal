all: help

.PHONY: help
help:
	@echo ""
	@echo "  COMMAND             DESCRIPTION"
	@echo "  everything          install everything"
	@echo "  vim-packages        install all vim packages"
	@echo "  list                list all make targets"
	@echo ""


.PHONY: everything
everything: homebrew git zsh vim nvim python pathogen vim-packages
	cp .zshrc ~/
	cp .vimrc ~/
	cp .bashrc ~/
	cp .gitconfig ~/
	cp .git_update.sh ~/
	cp .sync_master.py ~/
	cp .open_pull.py ~/
	cp .tmux.conf ~/

.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

.PHONY: homebrew
homebrew:
	@set -e; \
	which -s brew; \
	if [ $(strip "$$(which brew)") == "" ]; then \
		echo "Installing homebrew..."; \
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; \
	else \
		echo "Updating homebrew..."; \
		brew update; \
	fi;

.PHONY: git
git:
	@set -e; \
	if [ $(strip "$$(which git)") == "" ]; then \
		echo "Installing git..."; \
		brew install git; \
	fi;


.PHONY: zsh
zsh:
	@set -e; \
	if [ $(strip "$$(which zsh)") == "" ]; then \
		echo "Installing zsh..."; \
		brew install zsh zsh-completions; \
	fi;

.PHONY: vim
vim:
	@set -e; \
	if [ $(strip "$$(which vim)") == "" ]; then \
		echo "Installing vim..."; \
		brew install vim; \
		brew install macvim; \
		brew link macvim; \
		mkdir -p ~/.vim; \
	fi;

.PHONY: nvim
nvim:
	@set -e; \
	if [ $(strip "$$(which nvim)") == "" ]; then \
		echo "Installing neovim..."; \
		brew install neovim; \
		mkdir -p ~/.vim; \
	fi;

.PHONY: python
python:
	@set -e; \
	if [ $(strip "$$(which python)") == "" ]; then \
		echo "Installing python..."; \
		brew install python; \
	fi;


.PHONY: ruby
ruby:
	@set -e; \
	if [ $(strip "$$(which ruby)") == "" ]; then \
		echo "Installing ruby..."; \
		brew install ruby; \
	fi; \


.PHONY: tmux
tmux:
	@set -e; \
	if [ $(strip "$$(which tmuxinator)") == "" ]; then \
		echo "Installing tmux..."; \
		brew install tmux; \
	fi;


.PHONY: tmuxinator
tmuxinator: ruby
	@set -e; \
	if [ $(strip "$$(which tmuxinator)") == "" ]; then \
		echo "Installing tmuxinator..."; \
		gem install tmuxinator; \
	fi;


.PHONY: vim-packages
vim-packages: vim-pathogen vim-nerdtree vim-gitgutter vim-surround vim-easymotion vim-incsearch vim-YouCompleteMe vim-colors vim-ack vim-fugitive vim-rhubarb vim-tcomment vim-dart vim-lightline vim-ale vim-fzf vim-tmux-navigator

.PHONY: vim-pathogen
vim-pathogen:
	@set -e; \
	if [ ! -d ~/.vim/bundle/ ] ; then \
		echo "Installing pathogen..."; \
		mkdir -p ~/.vim/autoload ~/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim; \
	fi;

.PHONY: vim-nerdtree
vim-nerdtree:
	@set -e; \
	if [ ! -d ~/.vim/bundle/nerdtree/ ] ; then \
		echo "Installing nerdtree..."; \
		git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree; \
	fi;

.PHONY: vim-syntastic
vim-syntastic:
	@set -e; \
	if [ ! -d ~/.vim/bundle/syntastic/ ] ; then \
		echo "Installing syntastic..."; \
		git clone --depth=1 https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/syntastic; \
	fi;

.PHONY: vim-gitgutter
vim-gitgutter:
	@set -e; \
	if [ ! -d ~/.vim/bundle/vim-gitgutter/ ] ; then \
		echo "Installing vim-gitgutter..."; \
		git clone git://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter; \
	fi;


.PHONY: vim-surround
vim-surround:
	@set -e; \
	if [ ! -d ~/.vim/bundle/vim-surround/ ] ; then \
		echo "Installing vim-surround..."; \
		git clone git://github.com/tpope/vim-surround.git ~/.vim/bundle/vim-surround; \
	fi;


.PHONY: vim-easymotion
vim-easymotion:
	@set -e; \
	if [ ! -d ~/.vim/bundle/vim-easymotion/ ] ; then \
		echo "Installing vim-easymotion..."; \
		git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion; \
	fi;


.PHONY: vim-incsearch
vim-incsearch:
	@set -e; \
	if [ ! -d ~/.vim/bundle/incsearch.vim/ ] ; then \
		echo "Installing incsearch..."; \
		git clone https://github.com/haya14busa/incsearch.vim ~/.vim/bundle/incsearch.vim; \
		git clone https://github.com/haya14busa/incsearch-fuzzy.vim ~/.vim/bundle/incsearch-fuzzy.vim; \
		git clone https://github.com/haya14busa/incsearch-easymotion.vim ~/.vim/bundle/incsearch-easymotion.vim; \
	fi;


.PHONY: vim-YouCompleteMe
vim-YouCompleteMe:
	@set -e; \
	if [ ! -d ~/.vim/bundle/YouCompleteMe/ ] ; then \
		echo "Installing vim-easymotion..."; \
		git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe; \
		cd ~/.vim/bundle/YouCompleteMe; \
		git submodule update --init --recursive; \
		./install.sh --clang-completer; \
		cd; \
	fi;


.PHONY: vim-colors
vim-colors:
	@set -e; \
	if [ ! -d ~/.vim/colors/ ] ; then \
		echo "Installing vim-colors..."; \
		git clone git@github.com:sickill/vim-monokai.git; \
		mv vim-monokai/colors ~/.vim/; \
		rm -rf vim-monokai; \
	fi;

.PHONY: vim-ack
vim-ack:
	@set -e; \
	if [ ! -d ~/.vim/bundle/ack.vim/ ] ; then \
		echo "Installing ack..."; \
		git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim; \
	fi;

.PHONY: vim-fugitive
vim-fugitive:
	@set -e; \
	if [ ! -d ~/.vim/bundle/fugitive/ ] ; then \
		echo "Installing vim-fugitive..."; \
		git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive.vim; \
	fi;


.PHONY: vim-rhubarb
vim-rhubarb:
	@set -e; \
	if [ ! -d ~/.vim/bundle/vim-rhubarb/ ] ; then \
		echo "Installing vim-rhubarb..."; \
		git clone https://github.com/tpope/vim-rhubarb.git ~/.vim/bundle/vim-rhubarb.vim; \
	fi;


.PHONY: vim-tcomment
vim-tcomment:
	@set -e; \
	if [ ! -d ~/.vim/bundle/tcomment_vim/ ] ; then \
		echo "Installing tcomment_vim..."; \
		git clone git@github.com:tomtom/tcomment_vim.git ~/.vim/bundle/tcomment_vim; \
	fi;

.PHONY: vim-dart
vim-dart:
	@set -e; \
	if [ ! -d !/.vim/bundle/dart-vim-plugin/ ]; then \
		echo "Installing dart-vim-plugin..."; \
		git clone git@github.com/dart-lang/dart-vim-plugin.git ~/.vim/bundle/dart-vim-plugin; \
	fi;

.PHONY: vim-fzf
vim-fzf:
	@set -e; \
	if [ ! -d !/.vim/bundle/fzf.vim/ ]; then \
		echo "Installing fzf.vim..."; \
		git clone git@github.com:junegunn/fzf.vim.git ~/.vim/bundle/fzf.vim; \
		git clone git@github.com:junegunn/fzf.git ~/.vim/bundle/fzf; \
	fi;

.PHONY: vim-lightline
vim-lightline:
	@set -e; \
	if [ ! -d !/.vim/bundle/lightline.vim/ ]; then \
		echo "Installing lightline.vim..."; \
		git clone git@github.com:itchyny/lightline.vim.git ~/.vim/bundle/lightline.vim; \
	fi;

.PHONY: vim-ale
vim-ale:
	@set -e; \
	if [ ! -d !/.vim/bundle/ale/ ]; then \
		echo "Installing ale..."; \
		git clone git@github.com:w0rp/ale.git ~/.vim/bundle/ale; \
	fi;

.PHONY: vim-tmux-navigator
vim-tmux-navigator:
	@set -e; \
	if [ ! -d !/.vim/bundle/vim-tmux-navigator/ ]; then \
		echo "Installing vim-tmux-navigator..."; \
		git clone git@github.com:christoomey/vim-tmux-navigator.git ~/.vim/bundle/vim-tmux-navigator; \
	fi;
