#!/usr/bin/env bash

PUMBLE_WEBHOOK_PATH=$(cat ${HOME}/.config/.elizabeth-general-pumble-webhook)
LIST_OF_SERVERS=$(cat /etc/nginx/sites-available/*.conf | grep server_name | cut -d' ' -f2)

curl -X POST \
	--location "${PUMBLE_WEBHOOK_PATH}" \
	--data-urlencode "payload={\"text\":\"List of server names\`\`\`${LIST_OF_SERVERS}\`\`\`\"}" 
