#!/bin/bash

OUTPUT=$(docker compose exec -T mongos_router mongosh --quiet --eval "use somedb" --eval "db.helloDoc.countDocuments()" --port 27020)

if [[ $OUTPUT == 0 ]]; then
  OUTPUT=$(docker compose exec -T mongos_router mongosh --quiet --eval "use somedb" \
  --eval "for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:\"ly\"+i})" \
  --eval "db.helloDoc.countDocuments()" --port 27020)
fi

echo "Docs all: ${OUTPUT}"

OUTPUT=$(docker compose exec -T shard1_1 mongosh --quiet --eval "use somedb" --eval "db.helloDoc.countDocuments()" --port 27018)
echo "Docs on shard1: ${OUTPUT}"

OUTPUT=$(docker compose exec -T shard2_1 mongosh --quiet --eval "use somedb" --eval "db.helloDoc.countDocuments()" --port 27019)
echo "Docs on shard2: ${OUTPUT}"