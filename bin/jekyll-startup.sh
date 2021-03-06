#!/usr/bin/env bash
set -x
JEKYLL_LOGFILE=$HOME/jekyll_startup.log
exec >> $JEKYLL_LOGFILE 2>&1
if [ -e $HOME/pages/index.html ]; then 
  echo "Pages(index.html) Found"
  echo "starting jekyll"
  cd /home/gh-pages/pages 
  bundle exec jekyll serve ;
fi
if [ -e $HOME/pages/Gemfile ]; then 
  echo "Gemfile Detected"
else 
  cd $HOME
  echo "source 'https://rubygems.org'" > Gemfile
  echo "gem 'github-pages', group: :jekyll_plugins" >> Gemfile
  git init .
  cd $HOME && bundle install
  cd $HOME && bundle exec jekyll _3.8.5_ new pages
  cd $HOME/pages && bundle exec jekyll build
  cd $HOME/pages && bundle exec jekyll serve --watch --incremental --host=0.0.0.0
fi
