#!/usr/bin/env bash
#
# This file has executed after container's builds for custom code
#
# tech-stack: ubuntu / apache / php / Moodle
# actions: install update Moodle, config, add cron tasks
#
# @author demmonico
# @image ubuntu-apache-moodle
# @version v3.2



### install moodle
if [ ! -f "${DMC_APP_PROJECT_DIR}/config-dist.php" ]; then

    # clone repo
    git clone ${DMC_APP_MOODLE_REPOSITORY} ${DMC_APP_PROJECT_DIR}

    # removed because IOMAD hasn't tags - branches only
    # get latest tag if empty
    #if [ -z "${DMC_APP_MOODLE_TAG_VERSION}" ]; then DMC_APP_MOODLE_TAG_VERSION="$( git describe --tags --abbrev=0 --match v3.* )"; fi && \
    # checkout tag
    #cd ${DMC_APP_PROJECT_DIR} && git checkout tags/${DMC_APP_MOODLE_TAG_VERSION}

    # checkout version
    cd ${DMC_APP_PROJECT_DIR}
    if [ ! -z "${DMC_APP_MOODLE_TAG_VERSION}" ]
    then
        git checkout tags/${DMC_APP_MOODLE_TAG_VERSION}
    elif [ ! -z "${DMC_APP_MOODLE_BRANCH}" ]
    then
        git checkout -b temp origin/${DMC_APP_MOODLE_BRANCH}
    fi

    # remove git to prepare
    rm -rf "${DMC_APP_PROJECT_DIR}/.git"
fi



### config moodle
CONFIG_FILE="${DMC_APP_PROJECT_DIR}/config.php"
if [ ! -f ${CONFIG_FILE} ]; then
    # add configs
    yes | cp -rf "${DMC_INSTALL_DIR}/config.php" ${CONFIG_FILE}

    # FIX Moodle sitename for CLI scripts
    sed -i "s/\{\{ DMC_APP_MOODLE_HTTP_HOST \}\}/${VIRTUAL_HOST}/" ${CONFIG_FILE}

    # config db
    if [ ! -z "${DMC_DB_SERVICE}" ]
    then
        # db host
        sed -i "s/\{\{ DMC_APP_MOODLE_DB_HOST \}\}/${DMC_DB_SERVICE}/" ${CONFIG_FILE}
        # db name
        sed -i "s/\{\{ DMC_APP_MOODLE_DB_NAME \}\}/${DMC_DB_NAME:-${DM_PROJECT}}/" ${CONFIG_FILE}
    fi
fi



### add cron task
USER_NAME=$( getent passwd ${DM_HOST_USER_ID} | cut -d: -f1 )
CRON_LINE_MARKER='\#\#\# begin \# moodle scheduler \#'
CRON_NEW_LINES=$(
    echo '### begin # moodle scheduler #'
    echo "* * * * * /usr/bin/php -f ${DMC_APP_PROJECT_DIR}/admin/cli/cron.php > /dev/null 2>&1"
    echo '### end # moodle scheduler #'
)
CRON_LINES=$( crontab -u ${USER_NAME} -l > /dev/null 2>&1 )
( echo ${CRON_LINES} | ( grep -q -F "${CRON_LINE_MARKER}" > /dev/null 2>&1 || echo "${CRON_NEW_LINES}" ) ) | crontab -u ${USER_NAME} -
