#!/bin/bash

## backup script for postgres db
# define env vars to be used by pg client tools 
# PGUSER
# PGHOST
# PGPORT
# PGDATABASE
# PGOPTIONS

THIS_DIR=$(dirname $0)
ENV_FILE=${THIS_DIR}/.env.cron

# load env file and export values from it to shell
export $(grep -v '^#' ${ENV_FILE} | xargs -d '\n')

echo 'run pg backup', $(date)
echo 'with env'
env

# /$deployment/pg
_TARGET_DIR=/${RANCHER_STACK:-geonode-generic}/pg/

# /mnt/volumes/backup/$deployment/pg/$date
TARGET_DIR=${TARGET_DIR:-/mnt/volumes/backups/}/${_TARGET_DIR}/$(date +%Y%m%d)

# all above + filename
TARGET_FILE=${TARGET_DIR}/pg_dumpall-$(date '+%Y_%m_%d_%H%M_%S').tar.gz

mkdir -p ${TARGET_DIR}


# we don't provide credentials nor db location, since it's comming from env
pg_dumpall > ${TARGET_FILE}
