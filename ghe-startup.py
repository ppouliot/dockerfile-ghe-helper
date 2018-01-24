#! /usr/bin/env python

import os
import paramiko
from ghe import get_key, set_key, unset_key
from ghe import GHE
print ('==========================')
print ('* Detected GHE Variables *')
print ('==========================')
print (' ')
print ('* GHE_HOST: ', os.environ['GHE_HOST'])
print ('* GHE_SSH_USER: ', os.environ['GHE_SSH_USER'])
print ('* GHE_SSH_PORT: ', os.environ['GHE_SSH_PORT'])
print ('* GHE_USER: ', os.environ['GHE_USER'])
print ('* GHE_PASS: ', os.environ['GHE_PASS'])
print ('* GHE_TOKEN: ', os.environ['GHE_TOKEN'])
print ('* GH_TOKEN: ', os.environ['GH_TOKEN'])
print ('* GH_TOTP: ', os.environ['GHE_TOTP'])
print (' ')
print ('For available command type "help".'
print (' ')
set_key('ghe-host',(os.environ['GHE_HOST']))
set_key('ghe-ssh-user',(os.environ['GHE_SSH_USER']))
set_key('ghe-ssh-port',(os.environ['GHE_SSH_PORT']))
set_key('ghe-user',(os.environ['GHE_USER']))
set_key('ghe-pass',(os.environ['GHE_PASS']))
set_key('ghe-token',(os.environ['GHE_TOKEN']))
set_key('gh-token',(os.environ['GH_TOKEN']))
set_key('ghe-totp',(os.environ['GHE_TOTP']))


app = GHE()
app.cmdloop()

