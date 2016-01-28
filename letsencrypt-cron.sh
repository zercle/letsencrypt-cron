#!/bin/bash
# Auto renewal script for letsencrypt by crontab
# 0 0 1 */2 * /{PATH_TO}/letsencrypt-cron.sh > /var/log/letsencrypt-cron.log
# Created by @bouroo

# Set path
LETS_DIR="/root/letsencrypt"
CONFIG_FILES=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/conf/*.ini

# Change directory into letsencrypt path
cd "${LETS_DIR}" || exit 1
# Pull new letsencrypt
git pull
for ini in $CONFIG_FILES
do
./letsencrypt-auto certonly --renew-by-default -c "${ini}"
done
# Reload web server
service nginx reload
exit 0
