#!/bin/sh

USER=util01

echo "User setup"

useradd -m -s /bin/zsh -d /home/voluser/$USER $USER
echo "$USER:mot2passe" | chpasswd
adduser $USER sudo

cp ~/.zshrc /home/voluser/$USER/
sed -i 's/  export ZSH=\"\/root\/.oh-my-zsh\"/export ZSH=\"\/home\/voluser\/$USER\/.oh-my-zsh\"/' /home/voluser/$USER/.zshrc
cp -R ~/.oh-my-zsh /home/voluser/$USER


