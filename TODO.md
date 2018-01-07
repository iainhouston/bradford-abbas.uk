# To Do

Please ~~strike through a completed item~~ when done.

1. Automate ssh keys and config to allow remote AWS servers acccess to private git repos **or** rationalise composer repo URIs.

2. Find correct way to integrate our own Ansible roles and tasks with `vendor/geerlingguy/drupal-vm` roles and tasks.

3. Automate `dkim` configuration (on production server and not on staging server)

4. ~~Fix emacs directory error on provisioned servers: `Unable to access 'user-emacs-directory' (~/.emacs.d/).`~~
Not reproduced. Seemingly `.emacs.d` was  installed as root.

5. ~~Conflict with drush as provisioned; as required by composer;  and drush-wrapper. Other drush conflicts: go to dush:\~9.0; convert site_alias~~. Removed `drush-wrapper` and used `drush_launcher_version: "0.5.0"` and `drush_phar_url: https://github.com/drush-ops/drush-launcher/releases/download/{{ drush_launcher_version }}/drush.phar`

  All drush commands in roles work.

6. Investigate why `drush updb` fails first time after deployment of modified repo but not the second time playbook is run.

7. Automate? tweaks: `www.bradford-abbas.uk`; http -> https; DMIM email signing

8. ~~`secrets.yml` reequires vault password on `vagrant up`~~. `ENV['DRUPALVM_ANSIBLE_ARGS'] = '--ask-vault-pass'` in delegated `Vagrantfile` prevents `vagrant up` from failing; and asks for password.