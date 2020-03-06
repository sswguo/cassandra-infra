#!/bin/bash

help()
{
   echo ""
   echo "Usage: $0 -s service -o ops"
   echo -e "\t-o Please specify the keyspace to be backup."
   exit 1 # Exit script after printing help
}

while getopts "s:o:" opt
do
   case "$opt" in
      s ) service="$OPTARG" ;;
      o ) ops="$OPTARG" ;;
      ? ) help ;; # Print help in case parameter is non-existent
   esac
done

# Print help in case parameters are empty
if [ -z "$service" ] || [ -z "$ops" ]
then
   echo "Some or all of the parameters are empty";
   help
fi

exec()
{
    index=(0 1 2)
    if [ "$ops" = "drain" ]; then
        for i in "${index[@]}"
        do
          echo "drain the cassandra node '$service-$i'"
          oc rsh $service-$i nodetool drain
        done
    elif [ "$ops" = "delete" ]; then
        for i in "${index[@]}"
        do
          echo "delete(restart) the cassandra node '$service-$i'"
          oc delete pod/$service-$i
        done
    elif [ "$ops" = "repair" ]; then
        for i in "${index[@]}"
        do
          echo "nodetool repair on the cassandra node '$service-$i'"
          oc rsh $service-$i nodetool repair -pr --full
        done
    fi
}

### Main script starts here

exec