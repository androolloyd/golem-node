#!/bin/bash

set -ex
PROVIDER_HOME=/root/.local/share/ya-provider
cat > "$PROVIDER_HOME/globals.json" << EOF
{
  "node_name": "${NODE_NAME}",
  "subnet": "public-beta",
  "account": "${YA_ACCOUNT}"
}
EOF
bash -c "golemsp run"
