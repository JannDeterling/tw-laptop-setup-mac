#!/bin/sh

printInstallationStep(){
  colorOff='\033[0m'
  cyan='\033[0;36m'
  echo "${cyan}#### $1 #####${colorOff}"
}

appendZshrc(){
  echo "$1" >> ~/.zshrc
}

# Install homebrew
printInstallationStep "Install Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Tap cask for homebrow
printInstallationStep "Homebrew tap cask"
brew tap caskroom/cask

# Install zsh
printInstallationStep "install zsh"
brew install zsh

# SET zshell as default
printInstallationStep "setting zsh as the default shell"
chsh -s $(which zsh)

# Install google-chrome
printInstallationStep "Install Google Chrome"
brew cask install google-chrome

# Install iterm2
printInstallationStep "Install iterm2"
brew cask install iterm2

# Install Oh-my-zshell
printInstallationStep "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Node version manager
printInstallationStep "Install Node version manager"
brew install nvm

printInstallationStep "Update .zshrc configuration for NVM"
appendZshrc "#NVM"
appendZshrc "export NVM_DIR=~/.nvm"
appendZshrc "source $(brew --prefix nvm)/nvm.sh"

printInstallationStep "Source .zshrc"
source ~/.zshrc

# Download --lts of Node.js
printInstallationStep "Install latest Node.js version"
nvm install --lts

# Use nvm global default
printInstallationStep "Use default Node.js version"
nvm use default

# Use --lts always --> .zshrc
printInstallationStep "Update .zshrc to use latest version of node.js"

appendZshrc "nvm use default"

# Install openjdk8
printInstallationStep "Install OpenJDK 8"
brew cask install adoptopenjdk8

# Install jenv
printInstallationStep "Install JENV"
brew install jenv

# Install jenv export and maven
printInstallationStep "Install JENV plugins"

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

# Install maven
printInstallationStep "Install maven"
brew install maven

# Install gradle
printInstallationStep "Install gradle"
brew install gradle

# Install postman
printInstallationStep "Install postman"
brew cask install postman

# Install intellij toolbox
printInstallationStep "Install intellij toolbox"
brew cask install jetbrains-toolbox

# Install intellij community edition
printInstallationStep "Install intellij ce"
brew cask install intellij-idea-ce

# Install intellij ultimate
printInstallationStep "Install intellij ultimate"
brew cask install intellij-idea

### TWU specific ###

# Install Cisco AnyConnect
printInstallationStep "Cisco AnyConnect"

# Install postgresSQL app and command line tool
printInstallationStep "Install PostgreSQL"

# Download helloTWU




