How to set up the administrator account prior to provisioning the live server
-----------------------------------------------------------------------------

Instructions for generating, and information about the user names and passwords
are encrypted in `staging/secrets.yml`

From the project directory:

    ansible-vault view  staging/secrets.yml
    ansible-vault edit  staging/secrets.yml

Run the `init.yml` playbook:

    ansible-playbook -i staging/inventory \
    staging/init.yml -e "ansible_ssh_user=root" \
    --vault-password-file="~/.vaultpw"

 Now you are ready to provision the staging server.

     DRUPALVM_ENV=prod ansible-playbook vendor/geerlingguy/drupal-vm/provisioning/playbook.yml \
     --inventory-file=staging/inventory \
     --vault-password-file="~/.vaultpw" \
     --extra-vars="config_dir=$(pwd)/vm" \
     --skip-tags=test_only \
     --extra-vars="ansible_ssh_user=webadmin" \
     --ask-become-pass


