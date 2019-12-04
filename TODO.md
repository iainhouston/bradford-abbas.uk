# To Do

**Look at the end of the list for open iems.**

Please ~~strike through a completed item~~ when done.

1. ~~Automate ssh keys and config to allow remote AWS servers acccess to private git repos **or** rationalise composer repo URIs.~~

2. ~~Find correct way to integrate our own Ansible roles and tasks with `vendor/geerlingguy/drupal-vm` roles and tasks.~~

3. ~~Automate `dkim` configuration (on production server and not on staging server)~~

4. ~~Fix emacs directory error on provisioned servers: `Unable to access 'user-emacs-directory' (~/.emacs.d/).`~~
Not reproduced. Seemingly `.emacs.d` was  installed as root.

5. ~~Conflict with drush as provisioned; as required by composer;  and drush-wrapper. Other drush conflicts: go to dush:\~9.0; convert site_alias~~. Removed `drush-wrapper` and used `drush_launcher_version: "0.5.0"` and `drush_phar_url: https://github.com/drush-ops/drush-launcher/releases/download/{{ drush_launcher_version }}/drush.phar`

  All drush commands in roles "work" ....

6. ~~Investigate why `drush updb` fails first time after deployment of modified repo but not the second time playbook is run.~~ No longer reproduced. Went away after we started using `--tags=drupal`

7. Automate? tweaks: ~~`www.bradford-abbas.uk`~~; ~~http -> https~~; ~~DMIM email signing~~ Done.

8. ~~`secrets.yml` reequires vault password on `vagrant up`~~. `ENV['DRUPALVM_ANSIBLE_ARGS'] = '--ask-vault-pass'` in delegated `Vagrantfile` prevents `vagrant provision` from failing; and asks for password.

9. ~~post_provision_tasks to include setting `../tmp` and `sites/default/files/` to `www-data:www-data` **or** ensure that `webmaster` is included in admin group properly?~~

10. ~~Change from Varnish and Apache to Nginx - for ssl reasons and extra Varning software not really necessary additional complexity for our site.~~

11. ~~Update DNS settings: A records and TXT records for SPF.~~

12. ~~Raise issue with drush 9 rsync %files~~

13. ~~Raise issue with drush 9 rsync %files~~

14. ~~Place `~./ssh/config` to workaround drush alias bug not recognising `-i` argument~~ [See](https://github.com/drush-ops/drush/blob/master/examples/example.site.yml)

15. README.md:

    1. Re-order; review; re-organise

    2. ~~ansible-vault cert files (already in certs/README.txt)~~
    
16. Symbolic link to site=specific `drush`

    ```
    ln -s /var/www/drupalvm/vendor/drush/drush/drush /home/vagrant/.composer/vendor/bin/drush
    ```
