#!/bin/bash
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
  cd $HOME && bundle install
  cd $HOME && bundle exec jekyll _3.3.0_ new pages
  cd $HOME/pages && bundle exec jekyll build
  cd $HOME/pages && bundle exec jekyll serve --watch --incremental
fi

