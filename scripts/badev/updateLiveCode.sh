#!/usr/bin/env bash

ansible-playbook prod/update.playbook.yml \
	--inventory-file=prod/inventory \
	--extra-vars="project_dir=$(pwd)" \
	--vault-password-file="~/.vaultpw" \
	--ask-become-pass