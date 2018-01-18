#! /usr/bin/env python

import os 
from ghe import get_key, set_key, unset_key
from ghe import GHE
print os.environ['GHE_HOST']
print os.environ['GHE_SSH_USER']
print os.environ['GHE_SSH_PORT']
print os.environ['GHE_USER']
print os.environ['GHE_PASS']
print os.environ['GHE_TOKEN']
print os.environ['GH_TOKEN']
print os.environ['GHE_TOTP']

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

