#!/bin/bash
if [ -e /etc/motd ]; then 
  cat /etc/motd ;
fi
if [ -e /root/.ssh/id_rsa ] || [ -e /root/.ssh/id_dsa ] || [ -e /root/.ssh/id_ed25519  ] || [ -e /root/.ssh/id_ecdsa ]; then
  echo "SSH Keys Found."
  echo -n "Starting SSH_AGENT. "; eval `ssh-agent` &&  ssh-add ; 
  echo " " 
  echo "Starting GHE" 
  echo " " 
  /ghe-startup.py
else
  echo -n "No SSH Keys Found. Starting GHE"
  /ghe-startup.py
fi
