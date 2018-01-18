#!/bin/bash
if [ -e /root/.ssh/id_rsa ] || [ -e /root/.ssh/id_dsa ] || [ -e /root/.ssh/id_ed25519  ] || [ -e /root/.ssh/id_ecdsa ]; then
  echo -n "SSH Keys Found. Starting SSH_AGENT then GHE"
  eval `ssh-agent` &&  ssh-add ; /ghe-startup.py
else
  echo -n "No SSH Keys Found. Starting GHE"
  /ghe-startup.py
fi
