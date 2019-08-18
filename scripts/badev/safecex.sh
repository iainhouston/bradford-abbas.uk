#!/usr/bin/env bash

set -x

$DRUSH $DEVALIAS pmu devel kint
$DRUSH $DEVALIAS cex -y
