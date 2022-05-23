#!/bin/sh

if ! command -v brew &> /dev/null
then
    echo "homebrew could not be found, installing"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install rcm
brew install asdf

if [ ! -d "$HOME/.dotfiles" ]; then
    git clone https://github.com/clintcparker/dotfiles.git $HOME/.dotfiles
    git -C $HOME/.dotfiles remote set-url --push origin git@github.com:clintcparker/dotfiles.git
fi
chmod +x $HOME/.dotfiles/hooks/post-up

for tool in `cat tool-versions | awk '{ print $1 }'`; do
    echo "adding plugin $tool"
    asdf plugin-add $tool
    asdf plugin-update $tool
done


rcup

cd $HOME
asdf install 
brew bundle -v 
gem install bundler
bundle install

chsh -s `which fish`

asdf direnv setup --shell fish --version latest

fish -c "fish_add_path ~/.bin"

echo "Done!"
echo "type 'fish' to start using fish"
