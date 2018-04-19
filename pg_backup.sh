#!/bin/bash

## backup script for postgres db
# define env vars to be used by pg client tools 
# PGUSER
# PGHOST
# PGPORT
# PGDATABASE
# PGOPTIONS

echo 'run pg backup', $(date)
# get hostname 
HOSTNAME=${HOSTNAME:-$(hostname)}

# /$deployment/pg
_TARGET_DIR=/${RANCHER_STACK:-geonode-generic-${HOSTNAME}}/pg/

# /mnt/volumes/backup/$deployment/pg/$date
TARGET_DIR=${TARGET_DIR:-/mnt/volumes/backups/}/${_TARGET_DIR}/$(date +%Y%m%d)

# all above + filename
TARGET_FILE=${TARGET_DIR}/pg_dumpall-$(date '+%Y_%m_%d_%H%M_%S').tar.gz

mkdir -p ${TARGET_DIR}


# we don't provide credentials nor db location, since it's comming from env
pg_dumpall > ${TARGET_FILE}
