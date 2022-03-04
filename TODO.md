# To Do

**Look at the end of this list for completed iems.**

Please ~~strike through a completed item~~ when done.

1. Change staging init and inventory and drush alias to the same as live so we can just switch from staging to live just by editing DNS A records @ and www. and check relationship with `~/.ssh/config`

    ```
    ln -s /var/www/drupalvm/vendor/drush/drush/drush /home/vagrant/.composer/vendor/bin/drush
    ```

1. Remove `mailsystem` and `swiftmailer` lines in `post_provision_tasks/drupal_settings_files.yml` in branch to replace? `mailsystem` with `symfony mailer`

**Completed items**

Refreshed 29 Nov 2020
