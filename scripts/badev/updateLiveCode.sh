#!/usr/bin/env bash

DRUPALVM_ENV=prod ansible-playbook \
-i vm/inventory vendor/geerlingguy/drupal-vm/provisioning/playbook.yml \
-e "config_dir=$(pwd)/vm" --become --ask-become-pass --ask-vault-pass \
--tags=drupal
