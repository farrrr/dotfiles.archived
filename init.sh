#!/bin/bash

sudo add-apt-repository -y ppa:martin-frost/thoughtbot-rcm
sudo apt-get update
sudo apt-get -y install rcm

# load dotfiles
git clone --quiet https://github.com:farrrr/dotfiles ~/.dotfiles
rcup -f

# load Tmux plugins
git clone --quiet https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# load bash-it
git clone --quiet --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --no-modify-config
bash-it enable plugin alias-completion aws base docker extract git less-pretty-cat nginx node
bash-it enable completion bash-it brew bundler composer defaults docker-compose docker-machine docker export git git_flow git_flow_avh gradle kubectl minikube npm nvm ssh system tmux vault

# load SpaceVim
curl -sLf https://spacevim.org/install.sh | bash
nvim +SPInstall +qall

