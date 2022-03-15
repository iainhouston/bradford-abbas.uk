#!/usr/bin/env bash

echo "We'll need the file containig the Administrator's sudo password."
echo "This is the same password that automatically unencrypts secrets.yml"
echo "We're expecting to find this file here: ${HOME}/.vaultpw"

if [ -e ${HOME}/.vaultpw ]

then

    echo "${GREEN}About to update ${RED}Live${GREEN} Server{NC}"
    Start_time=$SECONDS
    
    becomepass=`cat ${HOME}/.vaultpw`

    ansible-playbook prod/update.playbook.yml \
        --inventory-file=prod/inventory \
        --extra-vars="project_dir=$(pwd)" \
        --extra-vars="ansible_become_pass=${becomepass}" \
        --vault-password-file="~/.vaultpw" 
    
    osascript -e 'display notification "Live system updated to latest code and configuration" with title "Task complete" sound name "Basso"'

    Elapsed_time=$(($SECONDS - $Start_time))
    echo "${GREEN}Updating of Live Server completed in ${RED}${Elapsed_time}${GREEN} seconds${NC}"

    exit 0

else

    echo "${RED}Couldn't find ${GREEN}${HOME}/.vaultpw{NC}"
    echo "Abandoning updating the Live Server"
    exit 1
    
fi
    