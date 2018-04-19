#!/bin/bash

THIS_DIR=$(dirname $0)

${THIS_DIR}/pg_backup.sh
${THIS_DIR}/fs_backup.sh
${THIS_DIR}/pg_backup.sh
