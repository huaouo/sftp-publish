#!/bin/bash

set -eux

USERNAME="$1"
SERVER="$2"
PORT="$3"
LOCAL_PATH="$4"
REMOTE_PATH="$5"
PKEY="$6"

TEMP_PRIVATE_KEY_FILE='../private_key.pem'
TEMP_SFTP_FILE='../sftp'

printf "%s\n" "$PKEY" > "$TEMP_PRIVATE_KEY_FILE"
chmod 600 "$TEMP_PRIVATE_KEY_FILE"

if [ -z "$REMOTE_PATH" ]; then
   echo 'remote-path is empty'
   exit 1
fi
ssh -o StrictHostKeyChecking=no -p "$PORT" -i "$TEMP_PRIVATE_KEY_FILE" "$USERNAME@$SERVER" "rm -rf $REMOTE_PATH/* && mkdir -p $REMOTE_PATH"

printf "%s" "put -r $LOCAL_PATH/* $REMOTE_PATH" >$TEMP_SFTP_FILE
sftp -b "$TEMP_SFTP_FILE" -P "$PORT" -o StrictHostKeyChecking=no -i "$TEMP_PRIVATE_KEY_FILE" "$USERNAME@$SERVER"

exit 0
