#!/bin/zsh

echo "${RED}Do you really want to do this?"
echo "${GREEN}mostRecentDev.sql${NC} is expected to contain the most recent Dev SQL to clone to Live"
echo "${GREEN}(Please choose a number in reply)${NC}"
select choice in "Yes" "No"; do
    case $choice in
        Yes ) echo "It's a yes. Here goes!"; break;;
        No ) exit 3;;
    esac
done

Start_time=$SECONDS

if [ -e mostRecentDev.sql ]
then

    echo "Emptying Live database"
    $DRUSH ${LIVEALIAS} sql:drop -y

    echo "Populating Live database"
    $DRUSH ${LIVEALIAS} sql:cli < mostRecentDev.sql

    echo "Rebuilding Drupal system after populating Live database"
    $DRUSH ${LIVEALIAS} cr

else
    echo "${RED}Couldn't find ${GREEN}mostRecentDev.sql${NC}"
    exit 1
fi

