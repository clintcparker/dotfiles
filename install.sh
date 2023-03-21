#!/bin/sh

#start timer
start=$SECONDS

echo "running install script 
     this will... 
       - install homebrew
       - install fish
            - set fish as default shell  
       - install rcm  
            - run rcup
       - install asdf  
           - and direnv  
       - install starship
       - install macos terminals"


# Install Homebrew
if ! command -v brew &> /dev/null
then
    echo "homebrew could not be found, installing"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

installEnv=macarm

# if /opt/homebrew/bin/brew exists, then we are on mac silicon
if [ -f "/opt/homebrew/bin/brew" ]; then
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.profile
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# if /usr/local/bin/brew exists, then we are on intel
if [ -f "/usr/local/bin/brew" ]; then
    installEnv=macintel
    (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> $HOME/.profile
    (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/usr/local/bin/brew shellenv)"
fi

# if /home/linuxbrew/.linuxbrew/bin/brew exists, then we are on linux
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    installEnv=linux
    echo "linux detected, configuring linuxbrew"
    sudo apt update
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    sudo apt-get install build-essential --fix-missing
    brew reinstall gcc
fi



brewpath=$(dirname $(which brew))


echo "Homebrew installed!"

# Install fish
brew install fish
# add fish to /etc/shells
which fish | sudo tee -a /etc/shells
chsh -s `which fish`


# Install rcm
brew install rcm

if [ ! -d "$HOME/.dotfiles" ]; then
    git clone https://github.com/clintcparker/dotfiles.git $HOME/.dotfiles
    git -C $HOME/.dotfiles remote set-url --push origin git@github.com:clintcparker/dotfiles.git
fi
chmod +x $HOME/.dotfiles/hooks/post-up

echo "rcm installed!"

cd $HOME
echo "now in:"
pwd
rcup

# Install asdf and asdf-direnv
brew install asdf
asdf plugin add direnv
asdf install direnv
asdf direnv setup --shell fish --version latest

# setup the shell & prompt
brew install starship



# brew bundle --global


# asdf plugin add ruby
# asdf install ruby 3.0.1
# gem install bundler
# bundle install --path $HOME/.bundle


#if not on linux, then setup the mac
if [ "$installEnv" != "linux" ]; then
    fish ~/.dotfiles/macos.fish
fi


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
echo "run 'update --all' to install all the things"


#  echo "type 'fish' to start using fish"
fish
