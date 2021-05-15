#!/bin/bash

if [ -z "${ENABLE_DYNAMIC_RATE}" ];
then
    exit 1
fi
RESULT=$(wget -qO- https://api.golemstats.com/v1/network/pricing/median )
#configure prices

echo $RESULT
ENV_DISCOUNT_RATE=${ENV_DISCOUNT_RATE:-0.001}
BASE=1
ENV_DISCOUNT=$(bc <<< "${BASE}-${ENV_DISCOUNT_RATE}")

HOUR_RATE=$(jq -r '.cpuhour' <<< "${RESULT}")
echo "CPU Hour Rate: ${HOUR_RATE}"
PER_HOUR=$(jq -r '.perhour'  <<< "${RESULT}")
echo "ENV Per Hour Rate: ${PER_HOUR}"
START_RATE=$(jq -r '.start'  <<< "${RESULT}")
echo "Start Rate: ${START_RATE}"

echo "Settings new Rates at $(bc <<< "$ENV_DISCOUNT_RATE*100")% of the market"
bash -c "golemsp settings set --cpu-per-hour $(bc <<< "$HOUR_RATE*$ENV_DISCOUNT") --env-per-hour $(bc <<< "$HOUR_RATE*$ENV_DISCOUNT") --starting-fee $(bc <<< "$START_RATE*$ENV_DISCOUNT")"
