#!/bin/bash

help()
{
   echo ""
   echo "Usage: $0 -s service"
   echo -e "\t-s Please specify the service to be backup."
   exit 1 # Exit script after printing help
}

while getopts "s:" opt
do
   case "$opt" in
      s ) service="$OPTARG" ;;
      ? ) help ;; # Print help in case parameter is non-existent
   esac
done

# Print help in case parameters are empty
if [ -z "$service" ] 
then
   echo "Some or all of the parameters are empty";
   help
fi

sync()
{
    index=(0 1 2)
    for i in "${index[@]}"
    do
        echo "rsync the script files into the cassandra node '$service-$i'"
        oc rsync remote/ $service-$i:/var/lib/cassandra/data/
    done
}

### Main script starts here

sync
