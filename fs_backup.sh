#!/bin/bash

echo 'run fs backup', $(date)
# /$deployment/pg
_TARGET_DIR=/${RANCHER_STACK:-geonode-generic}/fs/

# /mnt/volumes/backup/$deployment/pg/$date
TARGET_DIR=${TARGET_DIR:-/mnt/volumes/backups/}/${_TARGET_DIR}/$(date +%Y%m%d)

# all above + filename
TARGET_FILE=${TARGET_DIR}/data-$(date '+%Y_%m_%d_%H%M_%S').tar.gz

mkdir -p ${TARGET_DIR}

rclone --config /root/rclone.conf copy local:/mnt/volumes/data/  dest:${TARGET_DIR}/data/
rclone --config /root/rclone.conf copy local:/mnt/volumes/statics/  dest:${TARGET_DIR}/statics/
tar -czf ${TARGET_FILE} ${TARGET_DIR}/*

