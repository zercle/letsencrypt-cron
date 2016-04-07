#!/bin/bash
# Auto renewal script for letsencrypt by crontab
# 0 0 1 */2 * /{PATH_TO}/letsencrypt-cron.sh > /var/log/letsencrypt-cron.log
# Created by @bouroo

# Make letsencrypt-auto runable without needing to know the full path
if [[ ! -e /usr/local/bin/letsencrypt-auto ]]; then
	cd /usr/local || exit 1
	if [[ ! -e /usr/local/letsencrypt/letsencrypt-auto ]]; then
		git clone https://github.com/letsencrypt/letsencrypt.git
	fi
	chmod +x /usr/local/letsencrypt/letsencrypt-auto
	ln -s /usr/local/letsencrypt/letsencrypt-auto /usr/local/bin/letsencrypt-auto
fi

# Set config path
CONFIG_FILES=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/conf/*.ini

# Run with config in config path
for ini in $CONFIG_FILES
do
letsencrypt-auto certonly --renew-by-default -c "${ini}"
done
# Reload web server
service nginx reload
exit 0
