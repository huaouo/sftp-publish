#!/bin/bash

set -eux

USERNAME="$1"
SERVER="$2"
PORT="$3"
LOCAL_PATH="$4"
REMOTE_PATH="$5"
PKEY="$6"
PKEY_NAME="$7"

echo 'Creating the private key file...'
mkdir -p ~/.ssh
chmod 0700 ~/.ssh
printf "%s" "$PKEY" > ~/.ssh/"$PKEY_NAME"
chmod 0600 ~/.ssh/"$PKEY_NAME"

echo 'Creating lftp config file...'
echo 'set sftp:auto-confirm true' > ~/.ssh/.lftprc

echo 'Publishing to remote-path...'
lftp -u "$USERNAME," "sftp://$SERVER" <<< "mirror -R -e --transfer-all $LOCAL_PATH $REMOTE_PATH"

echo 'Done.'
exit 0
