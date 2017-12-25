#!/bin/sh

# Dev settings directory path (with settings from old mac)
dsd='./dev-settings'
git_username='ilaif'
git_email='ifallach@gmail.com'
do_install_apps=0 # TODO:

cd /tmp

echo "### Configuring global system defaults"
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1
defaults write com.apple.dock autohide-time-modifier -float 0.3; killall Dock

echo "### Installing xcode cli tools ###"
xcode-select --install

#echo "### Installing xcode cli tools ###"
#wget https://iterm2.com/downloads/stable/iTerm2-3_1_5.zip
#unzip -a iTerm2-3_1_5.zip

echo "### Installing Homebrew ###"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
brew update
brew doctor
brew tap caskroom/cask

echo "### Installing ZSH and Oh-my-ZSH ###"
brew install zsh zsh-completions
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
chsh -s /bin/zsh
/bin/cp $dsd/.zshrc ~/  # Will overwrite

echo "### Configuring iTerm2 ###"
echo "Please load ${dsd}/com.googlecode.iterm2.plist to iTerm using
Preferences -> General -> Load preferences from a custom folder or URL
and choose ${dsd} as the folder. When you finished click enter."
read input_var

echo "### Installing git"
brew install git
git --version
git config --global user.name "${git_username}"
git config --global user.email "${git_email}"
git config --global credential.helper osxkeychain

echo "### Installing atom"
# brew cask install atom
