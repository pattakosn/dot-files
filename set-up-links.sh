#!/bin/bash

if [[ -e ~/.gdbinit ]] ; then
  echo '~/.gdbinit : already exists, doing nothing'
else
  ln -s $PWD/gdbinit ~/.gdbinit
fi

if [[ -e ~/.vimrc ]] ; then
  echo '~/.vimrc : already exists, doing nothing'
else
  ln -s $PWD/vimrc ~/.vimrc
fi
if [[ -e ~/.ssh/id_rsa_lat.pub ]] ; then
  echo '~/.ssh/id_rsa_lat.pub : already exists, doing nothing'
else
  ln -s $PWD/id_rsa_lat.pub ~/.ssh/id_rsa_lat.pub
fi

if [[ -e ~/.ssh/id_rsa_pad.pub ]] ; then
  echo '~/.ssh/id_rsa_pad.pub : already exists, doing nothing'
else
  ln -s $PWD/id_rsa_pad.pub ~/.ssh/id_rsa_pad.pub
fi

if [[ -e ~/.ssh/config ]] ; then
  echo '~/.ssh/config : already exists, doing nothing'
else
  ln -s $PWD/ssh-config ~/.ssh/config
fi

if [[ -e ~/.vim/bundle/Vundle.vim ]] ; then
  echo '~/.vim/bundle/Vundle.vim : already exists, doing nothing'
else
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

pip install gdbgui

#~/.local/share/applications/firefox-beta.desktop
# konkor.github.io/cpufreq gnome-plugin
# /usr/share/vim-youcompleteme/plugin/youcompleteme.vim
#[user]
#	name = N. Pattakos
#	email = pattakosn@fastmail.com
