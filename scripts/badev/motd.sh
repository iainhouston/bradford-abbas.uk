echo "checkVersions  - Review  software required fot development"
echo "cloneLive2Dev  - Sync live database and static files to Dev server"
echo "endev          - Enable development modules in Dev site"
echo "safecex        - Safe export of Dev site's configuration"
echo "updateLiveCode - Code and Config to Live site"
echo "${GREEN}drush alias ${RED}${LIVEALIAS}${GREEN} for the Live Server at ${RED}https://${LIVESITE}${NC}"
echo "${GREEN}drush alias ${RED}${STAGEALIAS}${GREEN} for the Staging Server at ${RED}https://${STAGESITE}${NC}"
echo "${GREEN}drush alias ${RED}${DEVALIAS}${GREEN} for the Development Server at ${RED}http://${DEVSITE}${NC}"
