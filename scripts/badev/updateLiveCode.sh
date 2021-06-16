#!/usr/bin/env bash

Start_time=$SECONDS
ansible-playbook prod/update.playbook.yml \
	--inventory-file=prod/inventory \
	--extra-vars="project_dir=$(pwd)" \
	--vault-password-file="~/.vaultpw" \
	--ask-become-pass

osascript -e 'display notification "Live system updated to latest code and configuration" with title "Task complete" sound name "Basso"'

Elapsed_time=$(($SECONDS - $Start_time))
echo "${GREEN}Update attempt completed in ${RED}${Elapsed_time}${GREEN} seconds${NC}"
