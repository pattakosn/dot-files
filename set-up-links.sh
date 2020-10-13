#!/bin/bash

if [[ -e ~/.gdbinit ]] ; then
  echo '~/.gdbinit : already exists, doing nothing'
else
  ln -s ./gdbinit ~/.gdbinit
fi

if [[ -e ~/.vimrc ]] ; then
  echo '~/.vimrc : already exists, doing nothing'
else
  ln -s ./vimrc ~/.vimrc
fi
if [[ -e ~/.ssh/id_rsa_lat.pub ]] ; then
  echo '~/.ssh/id_rsa_lat.pub : already exists, doing nothing'
else
  ln -s ./id_rsa_lat.pub ~/.ssh/id_rsa_lat.pub
fi

if [[ -e ~/.ssh/id_rsa_pad.pub ]] ; then
  echo '~/.ssh/id_rsa_pad.pub : already exists, doing nothing'
else
  ln -s ./id_rsa_pad.pub ~/.ssh/id_rsa_pad.pub
fi

if [[ -e ~/.ssh/config ]] ; then
  echo '~/.ssh/config : already exists, doing nothing'
else
  ln -s ./ssh-config ~/.ssh/config
fi

~/.local/share/applications/firefox-beta.desktop
# konkor.github.io/cpufreq gnome-plugin
# /usr/share/vim-youcompleteme/plugin/youcompleteme.vim
#[user]
#	name = N. Pattakos
#	email = pattakosn@fastmail.com
