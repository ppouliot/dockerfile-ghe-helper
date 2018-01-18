#! /usr/bin/env python

from ghe import GHE
import os 

os.environment['GHE_HOST'] = 'ghe-host'
os.environment['GHE_SSH_USER'] = 'ghe-ssh-user'
os.environment['GHE_SSH_PORT'] = 'ghe-port'
os.environment['GHE_USER'] = 'ghe-user'
os.environment['GHE_PASS'] = 'ghe-pass'
os.environment['GHE_TOKEN'] = 'ghe-token'
os.environment['GH_TOKEN'] = 'gh-token'
os.environment['GHE_TOTP'] = 'ghe-totp'

app = GHE()
app.cmdloop()

