#!/bin/bash

echo 'Init configSrv'
docker compose exec -T configSrv mongosh --port 27017 <<EOF
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);
EOF
echo 'Init shard1'
docker compose exec -T shard1_1 mongosh --port 27018 <<EOF
use somedb

rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard1_1:27018" },
        { _id : 1, host : "shard1_2:27021" },
        { _id : 2, host : "shard1_3:27022" },
      ]
    }
);
EOF
echo 'Init shard2'
docker compose exec -T shard2_1 mongosh --port 27019 <<EOF
use somedb

rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 0, host : "shard2_1:27019" },
        { _id : 1, host : "shard2_2:27024" },
        { _id : 2, host : "shard2_3:27023" },
      ]
    }
  );
EOF
echo 'Init router'
docker compose exec -T mongos_router mongosh --port 27020 <<EOF
sh.addShard("shard1/shard1_1:27018");
sh.addShard("shard2/shard2_1:27019");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )

EOF


