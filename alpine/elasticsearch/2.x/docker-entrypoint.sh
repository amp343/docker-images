#!/bin/bash
set -e

# Compile config file templates
su-exec elasticsearch:elasticsearch confd -onetime -backend=$CONFD_BACKEND -prefix=/latest -confdir=/opt/elasticsearch

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

# Drop root privileges if we are running elasticsearch
# allow the container to be started with `--user`
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	# Change the ownership of /opt/elasticsearch/data to elasticsearch
	chown -R elasticsearch:elasticsearch /opt/elasticsearch/data
	set -- su-exec elasticsearch:elasticsearch "$@"
fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
