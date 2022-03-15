#!/bin/zsh

echo "${RED}Do you really want to do this?"
echo "${GREEN}library/provisioning/playbook.yml${NC} is expected to contain the most recent Live SQL"
echo "${GREEN}(Please choose a number in reply)${NC}"
select choice in "Yes" "No"; do
    case $choice in
        Yes ) echo "It's a yes. Here goes!"; 
            echo "You'll need the Administrator's sudo password."
            echo "This "
            break;;
        No ) exit 3;;
    esac
done

Start_time=$SECONDS

if [ -e ${HOME}/.vaultpw ]
then

    echo "${GREEN}About to provision ${RED}Live${GREEN} Server{NC}"
    
    cat ${HOME}/.vaultpw

    # DRUPALVM_ENV=prod ansible-playbook library/provisioning/playbook.yml \
    #      --inventory-file=prod/inventory \
    #      --vault-password-file="${HOME}/.vaultpw" \
    #      --extra-vars="config_dir=${pwd}/vm" \
    #      --skip-tags=test_only \
    #          --ask-become-pass
    
    Elapsed_time=$(($SECONDS - $Start_time))
    echo "${GREEN}Update attempt completed in ${RED}${Elapsed_time}${GREEN} seconds${NC}"

    exit 0

else
    echo "${RED}Couldn't find ${GREEN}${HOME}/.vaultpw{NC}"
    echo "Abandoning the provisioning of the Live Server"
        exit 1
    fi