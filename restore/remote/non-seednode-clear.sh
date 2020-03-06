#!/bin/bash

help()
{
   echo ""
   echo "Usage: $0 -k keyspace"
   echo -e "\t-k Please specify the keyspace to be backup."
   exit 1 # Exit script after printing help
}

while getopts "k:s:d:" opt
do
   case "$opt" in
      k ) keyspace="$OPTARG" ;;
      ? ) help ;; # Print help in case parameter is non-existent
   esac
done

# Print help in case parameters are empty
if [ -z "$keyspace" ]
then
   echo "Keyspace are empty";
   help
fi

clear()
{
    rm -r /var/lib/cassandra/commitlog/*.log
    rm -f /var/lib/cassandra/saved_cachs/*
    rm -rf /var/lib/cassandra/data/$keyspace/*
}

### Main script starts here

echo "Clear files from the keyspace '$keyspace'"

clear
