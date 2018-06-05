GeoNode backup container
========================


This repo contains docker build config for backup container to be used along with `geonode-generic` stack

Usage
-----


This container runs cron in foreground with one script scheduled to be run once a day, at 2:02.

Script `/root/backup.sh` will run
 * postgresql backup for all databases in stack
 * filesystem backup for GeoServer data dir and statics dir for GeoNode

PostgreSQL backup will be run twice, before and after filesystem backup. Each backup run will resutl in timestamped file.

All backup files are stored in `/mnt/volumes/backups/$rancher_stack_name/$backup_type/$date` directory, where:

 * `/mnt/volumes/backups/` is a persistent volume in container
 * `$rancher_stack_name` is a name of stack (as you can have multiple deployments using the same backup volume)
 * `$backup_type` is a name of backup part (`pg` for postgresql, `fs` for filesystem)
 * `$date` is a date of backup in `YYYYMMDD` format.

For example,

```
ls /mnt/volumes/backups/geonode-generic-sdffsdf/pg/20180419/:
-rw-r--r-- 1 root 184056 Apr 19 10:24 pg_dumpall-2018_04_19_1024_04.gz
-rw-r--r-- 1 root 184056 Apr 19 10:24 pg_dumpall-2018_04_19_1024_09.gz

ls /mnt/volumes/backups/geonode-generic-sdffsdf/fs/20180419/:
drwxr-xr-x 20 root   4096 Apr 19 10:22 data (there's data gs dir structure)
-rw-r--r--  1 root 190057 Apr 19 10:24 data-2018_04_19_1024_09.tar.gz
```

Configuration
-------------

Backup container requires several elemnts to work correctly:
 * persistent storages:
   * GeoServer data in `/mnt/volumes/data/`
   * GeoNode statics and uploads in `/mnt/volumes/statics/`
   * backups storage in `/mnt/volumes/backups/`

 * environment variables:
   * `RANCHER_STACK` - name of stack in which container is run
   * `RANCHER_ENV` - name of environment in which stack is run
   * `PGUSER`, `PGHOST`, `PGPASSWORD`, `PGOPTIONS` - postgresql client connection parameters (`PGUSER` and `PGHOST` should be enough in base scenario)
   * `TARGET_DIR` - optional, alternative base path for backups storage



