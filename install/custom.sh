#!/usr/bin/env bash
#
# This file has executed each time when container's starts for custom code.
#
# tech-stack: ubuntu / apache / php / Moodle
# actions: update code by Git and update composer relations
#
# @author demmonico
# @image ubuntu-apache-moodle
# @version v3.2



### update code
if [ ! -z ${DM_REPOSITORY} ] && [ -d "${DMC_APP_PROJECT_DIR}/.git" ]
then
    # update status
    setDummyStatus "Code is updating";
    # update code
    git pull origin ${DM_REPO_BRANCH}
fi



### install composer relations
if [ -f "${DMC_APP_PROJECT_DIR}/composer.json" ]
then
    # update status
    setDummyStatus "Composer relations is updating";
    # install
    composer install
fi
