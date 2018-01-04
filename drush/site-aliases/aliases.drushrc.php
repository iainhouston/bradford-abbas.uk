<?php
/**
 * @file
 * Drush Aliases for Example.com.
 */
 $aliases['live.bradford-abbas.uk'] = array(
  'uri' => 'bradford-abbas.uk',
  'root' => '/var/www/live/web',
  'remote-host' => 'live.bradford-abbas.uk',
  'remote-user' => 'ubuntu',
  'ssh-options' => '-o PasswordAuthentication=no -i ~/.ssh/BAPC-2.pem',
);
$aliases['balive'] = $aliases['live.bradford-abbas.uk'];

$aliases['local.bradford-abbas.uk'] = array(
  'uri' => 'local.bradford-abbas.uk',
  'root' => '/var/www/drupal/web',
  'remote-host' => 'local.bradford-abbas.uk',
  'remote-user' => 'vagrant',
  'ssh-options' => '-o "SendEnv PHP_IDE_CONFIG PHP_OPTIONS XDEBUG_CONFIG" -o PasswordAuthentication=no -i "' . (getenv('VAGRANT_HOME') ?: drush_server_home() . '/.vagrant.d') . '/insecure_private_key"',
  'path-aliases' => array(
    '%drush-script' => '/usr/local/bin/drush',
  ),
);
$aliases['badev'] = $aliases['local.bradford-abbas.uk'];
?>
