#!/bin/sh

# Install Homebrew
if ! command -v brew &> /dev/null
then
    echo "homebrew could not be found, installing"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# if /home/linuxbrew/.linuxbrew/bin/brew exists, then we are on linux
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    echo "linux detected, configuring linuxbrew"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    sudo apt-get install build-essential --fix-missing
fi

echo "Homebrew installed!"

# Install fish
brew install fish
chsh -s `which fish`
fish -c "fish_add_path ~/.bin"
fish -c "fish_add_path ~/.dotnet/tools"

echo "fish installed!"

# Install rcm
brew install rcm

if [ ! -d "$HOME/.dotfiles" ]; then
    git clone -b 3-7-23 https://github.com/clintcparker/dotfiles.git $HOME/.dotfiles
    git -C $HOME/.dotfiles remote set-url --push origin git@github.com:clintcparker/dotfiles.git
fi
chmod +x $HOME/.dotfiles/hooks/post-up

echo "rcm installed!"

cd $HOME
echo "now in:"
pwd
rcup






echo "Done!"
#  echo "type 'fish' to start using fish"
fish
