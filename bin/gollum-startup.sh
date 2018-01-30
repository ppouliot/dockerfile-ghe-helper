#!/bin/bash
if [ -e $HOME/wiki/Home.md ]; then 
  echo "Wiki(Home.md) Found"
  echo "starting gollum"
  cd /home/gh-pages/wiki && gollum ;
else
  echo "No Home.md found in $HOME/wiki."
  echo "Initializing new gollum wiki."
  cd $HOME/wiki
  git init .
  echo "## Your Gollum Wiki is now ready !" > Home.md
  echo "Home.md created. Staring Gollum."
  gollum 
fi
