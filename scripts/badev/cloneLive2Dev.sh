#!/bin/zsh

Start_time=$SECONDS

# Dump remote database to local sql
NOW=$(date +"%a-%H%M-%d%b%y")
FILE="$BADEV/vm/saved_sql/live/$NOW.sql"
echo "Clearing caches before dumping Live database"
$DRUSH ${LIVEALIAS} cr
echo "Dumping Live database"
$DRUSH ${LIVEALIAS} sql:dump --result-file=/tmp/devtemp.sql --gzip --extra-dump=--no-tablespaces
echo "Copying compressed SQL file to Dev machine"
scp $LIVE_SSH_ALIAS:/tmp/devtemp.sql.gz $FILE.gz
gunzip $FILE.gz

# drush uses rsync -t flag which writes extraneous text
# sed -i '' 's/^Connection to/-- Connection to/' $FILE

$DRUSH $DEVALIAS sql:drop -y
echo "Loading replica of Live database"
$DRUSH $DEVALIAS sql:cli < $FILE
# $DRUSH @badev cr

echo "Syncing files from Live to Dev machine"
rsync -avz $LIVE_SSH_ALIAS:/var/www/drupal/web/sites/default/files/ \
$BADEV/web/sites/default/files/ \
--exclude=js --exclude=php --exclude=css

osascript -e 'display notification "Dev Database and Files in sync with Live system" with title "Task complete" sound name "Basso"'

Elapsed_time=$(($SECONDS - $Start_time))
echo "${GREEN}Cloning Live to Dev system completed in ${RED}${Elapsed_time}${GREEN} seconds${NC}"
