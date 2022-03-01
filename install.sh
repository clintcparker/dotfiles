if ! command -v brew &> /dev/null
then
    echo "homebrew could not be found, installing"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install rcm
brew install asdf



for tool in `cat tool-versions | awk '{ print $1 }'`; do
    echo "adding plugin $tool"
    asdf plugin add $tool
done

rcup

cd $HOME
asdf install 
brew bundle -v 
gem install bundler
bundle install

chsh -s `which fish`