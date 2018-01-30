#!/bin/bash
ssh -t $GHE_HOST -p$GHE_SSH_PORT -l $GHE_SSH_USER tail -f /var/log/github/ghe-migrator.log
