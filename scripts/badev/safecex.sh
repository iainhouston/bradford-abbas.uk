#!/usr/bin/env bash

set -x

drush $DEVALIAS pmu link_css devel kint
drush $DEVALIAS cex -y
