Rsync the shell files into remote cassandra node:
```
local/rsync.sh -s $SERVICE
```

Drain and shut down each Cassandra node in the cluster, one node at a time.
```
local/ops.sh -s $SERVICE -o drain
```

Restore the data:
```
local/restore.sh -s $SERVICE -k $KEYSPACE -n $SNAPSHOT
```


Restart the cassandra node:
```
local/ops.sh -s $SERVICE -o delete
```

Repair the node:
```
local/ops.sh -s $SERVICE -o repair
```

Helpful links:  
[https://docs.bitnami.com/google-templates/infrastructure/cassandra/administration/backup-restore/](https://docs.bitnami.com/google-templates/infrastructure/cassandra/administration/backup-restore/)  
[https://docs.axway.com/bundle/APIGateway_762_CassandraGuide_allOS_en_HTML5/page/Content/CassandraTopics/cassandra_BUR.html](https://docs.axway.com/bundle/APIGateway_762_CassandraGuide_allOS_en_HTML5/page/Content/CassandraTopics/cassandra_BUR.html)
