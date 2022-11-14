#!/usr/bin/env zsh

Start_time=$SECONDS

echo "Retrieving database as SQL from most recent Amazon S3 bucket"
NOW=$(date +"%a-%H%M-%d%b%y")
FILE="${BADEV}/vm/saved_sql/live/${NOW}.sql"
s3cmd get --recursive s3://bradford-abbas.uk.db ${FILE}
echo "Emptying Drupal database on Dev machine"
$DRUSH ${DEVALIAS} sql:drop -y
echo "Restoring replica of Live database to DEV system"
$DRUSH ${DEVALIAS} sql:cli < ${FILE}

echo "Setting alias mostRecentS3Backup.sql to ${GREEN}${FILE}${NC}"
ln -sf ${FILE} mostRecentS3Backup.sql

echo "Retrieving compressed private files"
s3cmd get --recursive s3://bradford-abbas.uk.private-files-compressed /tmp/private-files-compressed.tar.gz
mkdir -p /tmp/private_files && tar -xf /tmp/private-files-compressed.tar.gz --directory /tmp/private_files
rsync -avh /tmp/private_files/var/www/drupal/private_files/ ${BADEV}/private_files/

echo "Retrieving compressed public files"
s3cmd get --recursive s3://bradford-abbas.uk.files-compressed /tmp/public_files-compressed.tar.gz
mkdir -p /tmp/public_files && tar -xf /tmp/public_files-compressed.tar.gz --directory /tmp/public_files
rsync -avh /tmp/public_files/var/www/drupal/web/sites/default/files/ \
${BADEV}/web/sites/default/files/ \
      --exclude=js --exclude=php --exclude=css

osascript -e 'display notification "Dev Database and Files in sync with those most recently backed up to Amazon S3" with title "Task complete" sound name "Basso"'

Elapsed_time=$(($SECONDS - $Start_time))
echo "${GREEN}Restoring S3 buckets to Dev system completed in ${RED}${Elapsed_time}${GREEN} seconds${NC}"

