#!/usr/bin/env bash

echo "Taking Live system out of maintenance mode"
$DRUSH ${LIVEALIAS} state:set system.maintenance_mode 0 --input-format=integer
$DRUSH ${LIVEALIAS} cache:rebuild
