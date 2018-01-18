#!/usr/bin/env bash

# Dump remote database to local sql
NOW=$(date +"%a-%H%M-%d%b%y")
FILE="$BADEV/vm/saved_sql/live/$NOW.sql"
echo "Clearing caches before dumping Live database"
drush @balive cr
echo "Dumping Live database to $FILE"
drush @balive sql-dump > $FILE

# drush uses rsync -t flag which writes extraneous text
sed -i '' 's/^Connection to/-- Connection to/' $FILE
