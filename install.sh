#!/bin/sh

if ! command -v brew &> /dev/null
then
    echo "homebrew could not be found, installing"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# if /home/linuxbrew/.linuxbrew/bin/brew exists, then we are on linux
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    echo "linux detected, installing linuxbrew"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    sudo apt-get install build-essential
fi

brew install rcm
# brew install asdf
# brew install fish

if [ ! -d "$HOME/.dotfiles" ]; then
    git clone https://github.com/clintcparker/dotfiles.git $HOME/.dotfiles
    git -C $HOME/.dotfiles remote set-url --push origin git@github.com:clintcparker/dotfiles.git
fi
chmod +x $HOME/.dotfiles/hooks/post-up

# cd $HOME/.dotfiles

# for tool in `cat tool-versions | awk '{ print $1 }'`; do
#     echo "adding plugin $tool"
#     asdf plugin-add $tool
#     asdf plugin-update $tool
# done


rcup

cd $HOME
echo "brew bundle --global"
brew bundle --global


echo "brew bundle --global"
brew bundle --global

# asdf install 


# chsh -s `which fish`

# asdf direnv setup --shell fish --version latest

/bin/bash -c brew bundle --global
/bin/bash -c gem install bundler
/bin/bash bundle install


fish -c "fish_add_path ~/.bin"

fish -c "fish_add_path ~/.dotnet/tools"

echo "Done!"
echo "type 'fish' to start using fish"
fish
