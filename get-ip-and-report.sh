#!/usr/bin/env bash

# Constants
IP_CHECK_PATH=ifconfig.me
LAST_REPORTED_PATH=${HOME}/.config/.last-reported-ip
PUMBLE_WEBHOOK_PATH=$(cat ${HOME}/.config/.elizabeth-ip-pumble-webhook)

IP_ADDRESS=$(curl -sS ${IP_CHECK_PATH})
LAST_REPORTED=$(cat ${LAST_REPORTED_PATH})

echo "Current IP address: '${IP_ADDRESS}'."
echo "Last reported address: '${LAST_REPORTED}'."

if [ "$IP_ADDRESS" = "$LAST_REPORTED" ]; then
	echo "Exiting script as IP didn't change."
	exit;
fi

echo $IP_ADDRESS > ${LAST_REPORTED_PATH}
echo "Wrote address '${IP_ADDRESS}' to '${LAST_REPORTED_PATH}'."

curl -X POST \
	--location "${PUMBLE_WEBHOOK_PATH}" \
	--data-urlencode "payload={\"text\":\"IP:\n\`${IP_ADDRESS}\`\"}"
echo "Send message to Pumble with address: '${IP_ADDRESS}'."
