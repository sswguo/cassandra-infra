#!/bin/bash

echo "[+] Starting Snapshot"
/usr/local/apache-cassandra/bin/nodetool snapshot -t "k1.PathMap-20191030153029"
echo "[+] Complete Snapshot"
