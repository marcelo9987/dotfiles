#!/bin/bash

MIC=$(pactl get-default-source)


if [[ -z "$MIC" ]]; then
	echo '{"text": "", "tooltip": "Sen micro detectado"}'
	exit 0
fi

MUTE=$(pactl get-source-mute "$MIC" | awk '{print $2}')


if [[ "$MUTE" == "yes" ]]; then
	ICON="   "
else
	ICON="  "
fi

echo "{\"text\": \"$ICON\", \"tooltip\": \"Micrófono: $MIC (mute=$MUTE)\"}"
