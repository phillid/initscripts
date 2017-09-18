#!/bin/bash

if [ -z $1 ] ; then
	echo missing argument: file to read
	exit 1
fi

file="$1"

sedargs=""
for var in \
	BINDIR \
	OPENRC_RUN \
	SYSCONFDIR \
	OPENRC_DIR \
	; do
	sedargs="${sedargs} -e s:\@${var}\@:${!var}:g "
done

cat "$file" | sed ${sedargs}
