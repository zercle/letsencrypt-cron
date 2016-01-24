#!/bin/bash
# Auto renewal script for letsencrypt by crontab
# 0 0 1 */2 * /{PATH_TO}/letsencrypt-cron.sh > /var/log/letsencrypt-cron.log
# Created by @bouroo

# Change directory into letsencrypt path
cd /root/letsencrypt || exit 1
# Pull new letsencrypt
git pull
# example.in.th
#./letsencrypt-auto certonly --renew-by-default -c "/{PATH_TO}/example.in.th.ini"
# Reload web server
service nginx reload
exit 0
