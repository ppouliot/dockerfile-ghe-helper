#!/bin/bash
users=(ENV['GITHUB_USERS'])
for u in "${users[@]}"
do 
  export GHE_USER_TO_SUSPEND=$u ;
  /usr/local/bin/suspend-user.rb
done
