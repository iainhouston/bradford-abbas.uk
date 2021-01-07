#!/bin/zsh

FILE=`find $BADEV -type f -iname $(ls -t ./vm/saved_sql/live | head -1) `
$DRUSH $DEVALIAS sql:drop -y
echo "Re-Loading most recent replica of Live database to Dev machine"
echo $FILE

$DRUSH $DEVALIAS sql:cli < $FILE
osascript -e 'display notification "Dev Database in sync with Live system" with title "Task complete" sound name "Hero"'
