#import terminals and set default
open ~/.config/terminals/Solarized\ Light.terminal  > /dev/null   
open ~/.config/terminals/Solarized\ Dark.terminal  > /dev/null   
defaults write com.apple.Terminal "Startup Window Settings" "Solarized Dark"
defaults write com.apple.Terminal "Default Window Settings" "Solarized Dark"
echo "Terminal settings will take effect after restart"