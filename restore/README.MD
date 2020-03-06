Rsync the shell files into remote cassandra node:
```
local/rsync.sh -s cassandra-wguo-test
```

Drain and shut down each Cassandra node in the cluster, one node at a time.
```
local/ops.sh -s cassandra-wguo-test -o drain
```

Restore the data:
```
local/restore.sh -s cassandra-wguo-test -k indyss -n indyss-01
```


Restart the cassandra node:
```
local/ops.sh -s cassandra-wguo-test -o delete
```

Repair the node:
```
local/ops.sh -s cassandra-wguo-test -o repair
```
