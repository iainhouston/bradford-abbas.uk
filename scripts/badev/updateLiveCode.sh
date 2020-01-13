#!/usr/bin/env bash

DRUPALVM_ENV=prod \
ansible-playbook vendor/iainhouston/drupal-vm/provisioning/playbook.yml \
--inventory-file=vm/inventory \
--tags=drupal   \
--extra-vars="config_dir=$(pwd)/vm" \
--become --ask-become-pass --ask-vault-pass
