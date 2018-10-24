#!/usr/bin/env bash

# Dump remote database to local sql
NOW=$(date +"%a-%H%M-%d%b%y")
FILE="$BADEV/vm/saved_sql/live/$NOW.sql"
echo "Clearing caches before dumping Live database"
drush @balive cr
echo "Dumping Live database"
drush @balive sql:dump > $FILE

# drush uses rsync -t flag which writes extraneous text
sed -i '' 's/^Connection to/-- Connection to/' $FILE

drush @badev sql:drop -y
echo "Loading replica of Live database"
drush @badev sql:cli < $FILE
drush @badev cr

echo "Syncing files from Live to Dev machine"
rsync -avz $LIVE_SSH_ALIAS:/var/www/drupal/web/sites/default/files/ \
$BADEV/web/sites/default/files/ \
--exclude=js --exclude=php --exclude=css
