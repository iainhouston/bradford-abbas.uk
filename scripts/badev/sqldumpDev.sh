#!/usr/bin/env bash

# Dump remote database to local sql
NOW=$(date +"%a-%H%M-%d%b%y")
FILE="$BADEV/vm/saved_sql/dev/$NOW.sql"
echo "Clearing caches before dumping dev database"
$DRUSH @badev cr
echo "Dumping dev database to $FILE"
$DRUSH @badev sql-dump > $FILE

# $DRUSH uses rsync -t flag which writes extraneous text
sed -i '' 's/^Connection to/-- Connection to/' $FILE
