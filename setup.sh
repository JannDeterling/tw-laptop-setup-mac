#!/bin/sh

# VARS
allreadyInstalled="already installed!"
tryingToInstall="trying to install:"

# COLORS
red='\033[0;31m'
green='\033[0;32m'
colorOff='\033[0m'
cyan='\033[0;36m'

# FUNCTIONS
printInstallationStep(){
  echo "$cyan#### $1 #####$colorOff"
}

printAlreadyInstalled(){
  echo "$green $1 $colorOff"
}

appendZshrc(){
  echo "$1" >> ~/.zshrc
}

installWithBrew(){
  printInstallationStep "$tryingToInstall $1"
  brew list "$1"
  if [ "$?" =  "1" ]
  then
    brew install "$1"
  else
    printAlreadyInstalled "$alreadyInstalled"
  fi
}

installWithBrewCask(){
  printInstallationStep "$tryingToInstall $1"
  brew cask list "$1"
  if [ "$?" =  "1" ]
  then
    brew cask install "$1"
  else
    printAlreadyInstalled "$alreadyInstalled"
  fi
}

### MAIN PROCESS ###

# Install homebrew
printInstallationStep "$tryingToInstall Homebrew"
brew list
if [ "$?" =  "1" ]
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  printAlreadyInstalled "$alreadyInstalled"
fi

# Tap cask for homebrow
printInstallationStep "Homebrew tap cask"
brew tap caskroom/cask

# Install zsh
installWithBrew zsh

# SET zshell as default
printInstallationStep "setting zsh as the default shell"
chsh -s $(which zsh)

# Install Oh-my-zshell
printInstallationStep "$tryingToInstall oh-my-zsh"
if [ -d "$DIRECTORY" ]; then
  printAlreadyInstalled "$alreadyInstalled"
else
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Install Node version manager
installWithBrew nvm

printInstallationStep "Update .zshrc configuration for NVM"
appendZshrc "#NVM"
appendZshrc "export NVM_DIR=~/.nvm"
appendZshrc "source $(brew --prefix nvm)/nvm.sh"

printInstallationStep "Source .zshrc"
source ~/.zshrc

# Download --lts of Node.js
printInstallationStep "$tryingToInstall latest Node.js version"
nvm install --lts

# Use nvm global default
printInstallationStep "Use default Node.js version"
nvm use default

# Use --lts always --> .zshrc
printInstallationStep "Update .zshrc to use latest version of node.js"
appendZshrc "nvm use default"

# Install openjdk8
installWithBrewCask adoptopenjdk8

# Install jenv
installWithBrew jenv

# Install jenv export and maven
printInstallationStep "Install JENV plugins"
jenv enable-plugin maven
jenv enable-plugin export

# Set global java_home to jdk8
printInstallationStep "Use OpenJDK as default"
jenv global "$(jenv versions | grep -o "openjdk64-1.8.[0-9]*.[0-9]*")"

# Add jenv lines --> .zshrc
printInstallationStep "Update .zshrc to initialize jenv"
appendZshrc "#JENV"
appendZshrc 'export PATH="$HOME/.jenv/bin:$PATH"'
appendZshrc 'eval "$(jenv init -)"'
appendZshrc 'jenv global $(jenv versions | grep -o "openjdk64-1.8.[0-9]*.[0-9]*")'

printInstallationStep "Source .zshrc"
source ~/.zshrc

# Install google-chrome
printInstallationStep "Skipping Google-Chrome"
#installWithBrewCask google-chrome

# Install iterm2
installWithBrewCask iterm2

# Install maven
installWithBrew maven

# Install gradle
installWithBrew gradle

# Install postman
installWithBrewCask postman

# Install intellij toolbox
installWithBrewCask jetbrains-toolbox

# Install intellij community edition
installWithBrewCask intellij-idea-ce

# Install intellij ultimate
installWithBrewCask intellij-idea