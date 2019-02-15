#!/usr/bin/env bash

printf -v line '=%.0s' {1..25}

echo "$line::Prereq apps::$line"

sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common


echo "$line::Version Managers::$line"
echo 'Installing nvm'
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
echo 'Installing rvm'
echo 'Establish gpg keys'
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
echo 'Installing pyenv'
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc


echo "$line::VIM config::$line"

echo 'Installing vim'
sudo apt install vim

echo 'Installing personal vim files/scripts'
git clone  --depth 1 git@github.com:si-mikey/vim.git ~/.vim
cp ~/.vim/.vimrc

echo 'Install vundle for installing plugins in .vimrc'
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo 'Open vim and run :PluginInstall'

echo 'Installing oh-my-zsh'
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo 'Installing fzf and fzf.vim'
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo 'Installing powerline fonts'
sudo apt install font-powerline

echo "$line::Docker$line"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get install docker-ce docker-ce-cli containerd.io


echo "$line::Installing Rust::$line"
curl -sSf https://static.rust-lang.org/rustup.sh | sh
