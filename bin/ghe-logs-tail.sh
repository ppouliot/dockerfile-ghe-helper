#!/bin/bash
ssh -t $GHE_HOST -p$GHE_SSH_PORT -l $GHE_SSH_USER ghe-logs-tail
