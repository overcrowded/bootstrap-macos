#!/usr/bin/env bash

# Install Bash and set as our shell
touch ~/.bash_profile
brew install bash
grep -q -F "/usr/local/bin/bash" /etc/shells || sudo sh -c 'echo "/usr/local/bin/bash" >> /etc/shells'

# Bash completion
brew install bash-completion
# Install Bash-It
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh
cp $BOOTSTRAP_MACOS_DIR/dotfiles/.bash_profile ~/
source ~/.bash_profile

# Setup Bash-It plugins
bash-it enable plugin aws base battery docker-compose \
    docker git-subrepo git go history java javascript node node nvm \
    osx-timemachine osx powerline pyenv python rails rbenv ruby ssh sshagent \
    tmux tmuxinator virtualenv


# Finally reload our configuration
bash-it reload

# Install colorls
gem install colorls
rbenv rehash

# Change Bash to be the default shell
chsh -s /usr/local/bin/bash
