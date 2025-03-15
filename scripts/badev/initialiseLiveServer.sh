#!/bin/zsh 

echo "${GREEN}About to initialise ${RED}Live${GREEN} Server{NC}"    
echo "${GREEN}with ${RED}webadmin${GREEN} Linux account"  
echo "with which the Live Serve's Drupal system is administered"
echo "This script assumes:"
echo "1) you've public key authentication to Live Server's ${RED}root${GREEN} account"
echo "2) the remote Live Server has ${RED}python3${GREEN} installed"
echo "3) the password that automatically unencrypts ${RED}prod/secrets.yml${GREEN}"
echo "   we're expecting to find the password in this file: ${HOME}/.vaultpw${NC}"
            
  
if [ -e ${HOME}/.vaultpw ]

then

    echo "${GREEN}Attempting to initialise ${RED}Live${GREEN} Server"
    echo "Should you be asked for a passphrase for your rsa key"
    echo "it probably means that you do not ${NC}currently${GREEN} have "
    echo "public key authentication to Live Server's ${RED}root${GREEN}account${NC}"

    Start_time=$SECONDS
    
    ansible-playbook prod/init.yml \
        --inventory-file=prod/inventory \
        --extra-vars="ansible_ssh_user=root" \
        --vault-password-file="~/.vaultpw"
        
    osascript -e 'display notification "Live system initialised with webadmin account" with title "Task complete" sound name "Basso"'    
    Elapsed_time=$(($SECONDS - $Start_time))
    echo "${GREEN}Provisioning of Live Server completed in ${RED}${Elapsed_time}${GREEN} seconds${NC}"

    exit 0

else

    echo "${RED}Couldn't find ${GREEN}${HOME}/.vaultpw{NC}"
    echo "Abandoning the initialisation of the Live Server"
    exit 1
    
fi
