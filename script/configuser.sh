#!/bin/sh

USER=$1

echo "User setup"

cp /system/etc/passwd /etc/passwd
cp /system/etc/shadow /etc/shadow

useradd -m -s /bin/zsh -d /home/voluser/$USER $USER
echo "$USER:mot2passe" | chpasswd
adduser $USER sudo

cp ~/.zshrc /home/voluser/$USER/
sed -i 's/  export ZSH=\"\/root\/.oh-my-zsh\"/export ZSH=\"\/home\/voluser\/'$USER'\/.oh-my-zsh\"/' /home/voluser/$USER/.zshrc
cp -R ~/.oh-my-zsh /home/voluser/$USER
chown -R $USER:$USER /home/voluser/$USER/.oh-my-zsh
chown -R $USER:$USER /home/voluser/$USER/.zshrc

cp /etc/passwd /system/etc/passwd
cp /etc/shadow /system/etc/shadow
