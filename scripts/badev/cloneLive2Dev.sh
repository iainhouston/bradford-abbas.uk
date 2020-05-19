#!/bin/zsh

# Dump remote database to local sql
NOW=$(date +"%a-%H%M-%d%b%y")
FILE="$BADEV/vm/saved_sql/live/$NOW.sql"
echo "Clearing caches before dumping Live database"
$DRUSH @balive cr
echo "Dumping Live database"
$DRUSH @balive sql:dump --result-file=/var/www/drupal/temp.sql --gzip
scp $LIVE_SSH_ALIAS:/var/www/drupal/temp.sql.gz $FILE.gz
gunzip $FILE.gz

# drush uses rsync -t flag which writes extraneous text
# sed -i '' 's/^Connection to/-- Connection to/' $FILE

$DRUSH @badev sql:drop -y
echo "Loading replica of Live database"
$DRUSH @badev sql:cli < $FILE
# $DRUSH @badev cr

echo "Syncing files from Live to Dev machine"
rsync -avz $LIVE_SSH_ALIAS:/var/www/drupal/web/sites/default/files/ \
$BADEV/web/sites/default/files/ \
--exclude=js --exclude=php --exclude=css

osascript -e 'display notification "Dev Database and Files in sync with Live system" with title "Task complete" sound name "Basso"'
