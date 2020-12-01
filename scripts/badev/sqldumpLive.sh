#!/usr/bin/env bash

# Dump remote database to local sql
NOW=$(date +"%a-%H%M-%d%b%y")
FILE="$BADEV/vm/saved_sql/live/$NOW.sql"
echo "Clearing caches before dumping Live database"
$DRUSH ${LIVEALIAS} cr
echo "Dumping Live database to $FILE"
$DRUSH ${LIVEALIAS} sql-dump > $FILE

# $DRUSH uses rsync -t flag which writes extraneous text
sed -i '' 's/^Connection to/-- Connection to/' $FILE
