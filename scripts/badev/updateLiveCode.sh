#!/usr/bin/env bash

DRUPALVM_ENV=prod \
ansible-playbook vendor/geerlingguy/drupal-vm/provisioning/playbook.yml \
--inventory-file=vm/inventory \
--tags=drupal   \
--extra-vars="config_dir=$(pwd)/vm" \
--vault-password-file="~/.vaultpw" \
--become --ask-become-pass
