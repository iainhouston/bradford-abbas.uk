#!/usr/bin/env bash

set -x

$DRUSH $DEVALIAS pmu link_css devel kint
$DRUSH $DEVALIAS cex -y
