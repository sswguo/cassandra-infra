#!/bin/bash

help()
{
   echo ""
   echo "Usage: $0 -s service -k keyspace -n snapshot"
   echo -e "\t-s Please specify the service to be restored."
   echo -e "\t-k Please specify the keyspace to be backup."
   echo -e "\t-n Please specify the snapshot to be restored."
   exit 1 # Exit script after printing help
}

while getopts "s:k:n:" opt
do
   case "$opt" in
      s ) service="$OPTARG" ;;
      k ) keyspace="$OPTARG" ;;
      n ) snapshot="$OPTARG" ;;
      ? ) help ;; # Print help in case parameter is non-existent
   esac
done

# Print help in case parameters are empty
if [ -z "$service" ] || [ -z "$keyspace" ] || [ -z "$snapshot" ]
then
   echo "Some or all of the parameters are empty";
   help
fi

restore()
{
    oc rsh $service-0 /var/lib/cassandra/data/restore.sh -k $keyspace -n $snapshot
    oc rsh $service-1 /var/lib/cassandra/data/non-seednode-clear.sh -k $keyspace
    oc rsh $service-2 /var/lib/cassandra/data/non-seednode-clear.sh -k $keyspace
}

restore
