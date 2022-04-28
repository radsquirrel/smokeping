#!/bin/sh
set -eu

# validate that none of the required environment variables are empty
if [ -z "${HOSTS}" ]; then
	echo "ERROR: Missing one or more of the following variables"
	echo "  HOSTS"
	exit 1
fi

cat >/usr/bin/smokeping_prober <<EOF
#!/bin/sh
exec /usr/lib/smokeping_prober/smokeping_prober ${ARGS:-} ${HOSTS}
EOF
chmod 755 /usr/bin/smokeping_prober

# run CMD
echo "INFO: entrypoint complete; executing '${*}'"
exec "${@}"
