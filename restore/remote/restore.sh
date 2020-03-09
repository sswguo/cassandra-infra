#!/bin/bash

help()
{
   echo ""
   echo "Usage: $0 -k keyspace -n snapshot"
   echo -e "\t-k Please specify the keyspace to be backup."
   echo -e "\t-s Please specify the snapshot to be restored."
   exit 1 # Exit script after printing help
}

dry_run=0

while getopts "k:n:d:" opt
do
   case "$opt" in
      k ) keyspace="$OPTARG" ;;
      n ) snapshot="$OPTARG" ;;
      d ) dry_run=1;;
      ? ) help ;; # Print help in case parameter is non-existent
   esac
done

# Print help in case parameters are empty
if [ -z "$keyspace" ] || [ -z "$snapshot" ]
then
   echo "Some or all of the parameters are empty";
   help
fi

clear()
{
  #TODO Before starting to backup and restore, it's better to do snapshot first
  echo "Clear the data."
  if [ "$dry_run" -eq 1 ]; then
    echo "[dry_run] clear data"
  else
    echo "clear all files in the commitlog and saved_caches directory"
    rm -r /var/lib/cassandra/commitlog/*
    rm -f /var/lib/cassandra/saved_caches/*
    echo "clear the keyspace data"
    ls -lh /var/lib/cassandra/data/$keyspace/*/*.db
    rm /var/lib/cassandra/data/$keyspace/*/*.db
  fi
  echo "Clear data done."
}

pickSnapshot()
{
  echo "Pick snaphsot $snapshot"
  for t in "${tables[@]}"
  do
    echo "table `(basename /var/lib/cassandra/data/$keyspace/$t*)`"
    if [ "$dry_run" -eq 1 ]; then
      echo "[dry_run] copy"
      ls -lh /var/lib/cassandra/data/$keyspace/$t*/snapshots/$snapshot
    else
      cp /var/lib/cassandra/data/$keyspace/$t*/snapshots/$snapshot/* /var/lib/cassandra/data/$keyspace/$t*/
    fi
  done
  echo "Copy snapshot done."
}

fresh()
{
  for t in "${tables[@]}"
  do
    if [ "$dry_run" -eq 1 ]; then
      echo "[dry_run] refresh table $t"
    else
      echo "refresh table $t"
      nodetool refresh $keyspace $t
    fi
  done
  if [ "$dry_run" -eq 1 ]; then
    echo "[dry_run] repair the keyspace $keyspace."
  else
    echo "repair the keyspace $keyspace."
    #nodetool repair $keyspace
  fi
}

### Main script starts here

echo "Restore the keyspace '$keyspace' from the snapshot '$snapshot'"
echo "DryRun $dry_run"

#tables=("pathmap" "filechecksum" "reclaim" "reversemap")
tables=("pathmap")

clear
pickSnapshot
fresh
