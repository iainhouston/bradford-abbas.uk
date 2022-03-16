#!/bin/zsh

echo "${RED}Do you really want to do this?"
echo "${GREEN}mostRecentLive.sql${NC} is expected to contain the most recent Live SQL"
echo "${GREEN}(Please choose a number in reply)${NC}"
select choice in "Yes" "No"; do
    case $choice in
        Yes ) echo "It's a yes. Here goes!"; break;;
        No ) exit 3;;
    esac
done

Start_time=$SECONDS

if [ -e mostRecentLive.sql ]
then

    echo "Emptying Live database"
    $DRUSH ${LIVEALIAS} sql:drop -y

    echo "Populating Live database"
    $DRUSH ${LIVEALIAS} sql:cli < mostRecentLive.sql

    echo "Rebuilding Drupal system after populating Live database's config and data"
    $DRUSH ${LIVEALIAS} cr

else
    echo "${RED}Couldn't find ${GREEN}mostRecentLive.sql${NC}"
    exit 1
fi

if [ -e $BADEV/web/sites/default/files/ ]
then

    echo "Syncing static files from Dev to Live server"
    rsync -avz $BADEV/web/sites/default/files/ $LIVE_SSH_ALIAS:/var/www/drupal/web/sites/default/files/ \
        --exclude=js --exclude=php --exclude=css

    osascript -e 'display notification "Live Database and Files in sync with Dev virtual server" with title "Task complete" sound name "Basso"'

    Elapsed_time=$(($SECONDS - $Start_time))
    echo "${GREEN}Populated Live data in ${RED}${Elapsed_time}${GREEN} seconds${NC}"

else
    echo "${RED}Couldn't find ${GREEN}$BADEV/web/sites/default/files/{NC}"
    exit 2
fi
