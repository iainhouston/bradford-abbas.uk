#!/usr/bin/env bash

echo "Putting Live system into maintenance mode"
$DRUSH ${LIVEALIAS} state:set system.maintenance_mode 0 --input-format=integer
$DRUSH ${LIVEALIAS} cache:rebuild