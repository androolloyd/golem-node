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

#configure prices

bash -c "golemsp settings set --cpu-per-hour ${CPU_HOUR_RATE:-0.11} --env-per-hour ${ENV_PER_HOUR_RATE:-0.02} --starting-fee ${START_RATE:-0} --cores ${CPU_SHARED_CORES:-2} && golemsp run"
