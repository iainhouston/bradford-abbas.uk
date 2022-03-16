#!/bin/zsh 

echo "${RED}Do you really want to do this?"
echo "${GREEN}(Please enter a number now)${NC}"

select choice in "Yes" "No"; do
    case $choice in
    
        Yes ) 
            echo "${GREEN}It's a ${RED}Yes. ${GREEN}Here goes!${NC}"
            echo " "
            echo "We'll need the file containig the Administrator's sudo password."
            echo "This is the same password that automatically unencrypts secrets.yml"
            echo "We're expecting to find this file here: ${HOME}/.vaultpw"
            break;;
        No ) 
            echo "Abandoning execution of this script at your request"            
            exit 3;;
            
    esac
done

if [ -e ${HOME}/.vaultpw ]

then

    echo "${GREEN}About to provision ${RED}Live${GREEN} Server{NC}"
    Start_time=$SECONDS
    
    becomepass=`cat ${HOME}/.vaultpw`

    DRUPALVM_ENV=prod ansible-playbook library/provisioning/playbook.yml \
         --inventory-file=prod/inventory \
         --vault-password-file="${HOME}/.vaultpw" \
         --extra-vars="config_dir=${pwd}/vm" \
         --extra-vars="ansible_become_pass=${becomepass}" \
         --skip-tags=test_only 

    osascript -e 'display notification "Live system provisioned with latest code and configuration" with title "Task complete" sound name "Basso"'    
    Elapsed_time=$(($SECONDS - $Start_time))
    echo "${GREEN}Provisioning of Live Server completed in ${RED}${Elapsed_time}${GREEN} seconds${NC}"

    exit 0

else

    echo "${RED}Couldn't find ${GREEN}${HOME}/.vaultpw{NC}"
    echo "Abandoning the provisioning of the Live Server"
    exit 1
    
fi