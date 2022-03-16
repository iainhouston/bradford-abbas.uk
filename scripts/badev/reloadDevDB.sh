#!/bin/zsh

echo "Re-loading Drupal database on Development Server"
echo "${GREEN}mostRecentLive.sql${NC} is expected to contain the most recent Live SQL"


if [ -e mostRecentLive.sql ]
then

    Start_time=$SECONDS

    echo "Emptying Dev database"
    $DRUSH ${DEVALIAS} sql:drop -y

    echo "Populating Dev database"
    $DRUSH ${DEVALIAS} sql:cli < mostRecentLive.sql

    echo "Rebuilding Drupal system's PHP cache after populating Dev database"
    $DRUSH ${DEVALIAS} cr

    Elapsed_time=$(($SECONDS - $Start_time))
    echo "${GREEN}Reloaded Dev database in ${RED}${Elapsed_time}${GREEN} seconds${NC}"
    osascript -e 'display notification "Dev Database reloaded" with title "Task complete" sound name "Hero"'

else

    echo "${RED}Couldn't find ${GREEN}mostRecentLive.sql${NC}"
    exit 1

fi
