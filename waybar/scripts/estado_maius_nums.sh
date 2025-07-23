#!/bin/bash

# Obten os datos de dispositivos
DEVICES=$(hyprctl devices -j)

# Comproba capslock en calquera teclado
CAPS=$(echo $DEVICES | jq '[.keyboards[] | select(.capsLock==true)] | any')

# Comproba numlock en calquera teclado
NUM=$(echo "$DEVICES" | jq '[.keyboards[] | select(.numLock==true)] | any')

ICON=""

if [ "$CAPS" = "true" ]; then
    ICON+="🔒 Caps "
else
    ICON+="🔐 Caps "
fi

if [ "$NUM" = "true" ]; then
    ICON+="| 🔢 Num"
else
    ICON+="| ⭕ Num"
fi

echo "{\"text\": \"$ICON\", \"tooltip\": \"MAIÚS=$CAPS | NUM=$NUM\"}"

