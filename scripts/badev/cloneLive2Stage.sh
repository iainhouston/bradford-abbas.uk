#!/bin/zsh

set -o xtrace

# Dump remote database to local sql
NOW=$(date +"%a-%H%M-%d%b%y")
FILE="$BADEV/vm/saved_sql/live/$NOW.sql"
echo "Clearing caches before dumping Live database"
$DRUSH @balive cr
echo "Dumping Live database"
echo "-- Ignore mysqldump error --"
$DRUSH @balive sql:dump --result-file=/tmp/devtemp.sql --gzip
echo "Copying compressed SQL file to Dev machine"
scp $LIVE_SSH_ALIAS:/tmp/devtemp.sql.gz $FILE.gz
gunzip $FILE.gz

# drush uses rsync -t flag which writes extraneous text
# sed -i '' 's/^Connection to/-- Connection to/' $FILE

$DRUSH $STAGEALIAS sql:drop -y
echo "Loading replica of Live database to Staging machine"
$DRUSH $STAGEALIAS sql:cli < $FILE

echo "Syncing files from Live to Dev machine"
rsync -avz $LIVE_SSH_ALIAS:/var/www/drupal/web/sites/default/files/ \
$BADEV/web/sites/default/files/ \
--exclude=js --exclude=php --exclude=css

echo "Syncing files from Dev to Staging machine"
rsync -avz $BADEV/web/sites/default/files/ \
$STAGING_SSH_ALIAS:/var/www/drupal/web/sites/default/files/ \
--exclude=js --exclude=php --exclude=css

$DRUSH $STAGEALIAS cr
osascript -e 'display notification "Staging Database and Files in sync with Live system" with title "Task complete" sound name "Basso"'
