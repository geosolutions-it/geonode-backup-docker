#!/bin/bash

# we need runtime env from container,
# cron limits it to shell and path.
# so we dump it from entrypoint, and include in backup scripts
THIS_DIR=$(dirname $0)
env > ${THIS_DIR}/.env.cron
echo 'dumped env'
cat ${THIS_DIR}/.env.cron

echo 'running cron'
/usr/bin/crontab -l
exec /usr/sbin/cron -f
