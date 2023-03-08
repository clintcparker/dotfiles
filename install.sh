#!/bin/sh

#start timer
start=$SECONDS


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
    brew install gcc
    sudo apt-get install build-essential --fix-missing
fi

echo "Homebrew installed!"

# Install fish
brew install fish
# add fish to /etc/shells
which fish | sudo tee -a /etc/shells
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

brew install asdf

asdf plugin add direnv
asdf install direnv 2.30.3
asdf plugin add ruby
asdf install ruby 3.0.1
asdf plugin add rust
asdf install rust 1.60.0

brew install starship
brew install thefuck

# brew bundle --global
gem install bundler
# bundle install --path $HOME/.bundle

asdf direnv setup --shell fish --version latest

#end timer
duration=$(( SECONDS - start ))
if (( $duration > 3600 )) ; then
    let "hours=duration/3600"
    let "minutes=(duration%3600)/60"
    let "seconds=(duration%3600)%60"
    echo "Completed in $hours hour(s), $minutes minute(s) and $seconds second(s)" 
elif (( $duration > 60 )) ; then
    let "minutes=(duration%3600)/60"
    let "seconds=(duration%3600)%60"
    echo "Completed in $minutes minute(s) and $seconds second(s)"
else
    echo "Completed in $duration seconds"
fi

echo "Done!"
#  echo "type 'fish' to start using fish"
fish
