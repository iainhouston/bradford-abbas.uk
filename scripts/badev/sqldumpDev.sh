#!/bin/zsh

# Dump remote database to local sql
NOW=$(date +"%a-%H%M-%d%b%y")
FILE="$BADEV/vm/saved_sql/dev/$NOW.sql"
echo "Clearing caches before dumping dev database"
$DRUSH $DEVALIAS cr
echo "Dumping dev database to $FILE"
$DRUSH $DEVALIAS sql:dump --extra-dump=--no-tablespaces > $FILE

# $DRUSH uses rsync -t flag which writes extraneous text
sed -i '' 's/^Connection to/-- Connection to/' $FILE

echo "Setting alias mostRecentDev.sql to ${GREEN}${FILE}${NC}"
ln -sf ${FILE} mostRecentDev.sql
