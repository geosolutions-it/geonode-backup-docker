#!/bin/bash

THIS_DIR=$(dirname $0)
THIS_LOG=${THIS_DIR}/cron.log

source ${THIS_DIR}/.env.cron

${THIS_DIR}/fs_backup.sh
${THIS_DIR}/pg_backup.sh

