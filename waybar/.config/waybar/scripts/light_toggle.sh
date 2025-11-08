#!/usr/bin/env bash
source ~/.config/waybar/scripts/secrets

mosquitto_pub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASS" \
  -t "zigbee2mqtt/Skrivbordslampa/set" -m '{"state":"TOGGLE"}'
