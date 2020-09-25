#!/bin/sh

this_folder=$(dirname $(readlink -f $0))
if [ -z $this_folder ]; then
	this_folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
fi
parent_folder=$(dirname $this_folder)

resource_group=kubone
subscription="Free Trial"
cluster=clusterone

az aks get-credentials --resource-group "$resource_group" --subscription "$subscription" --name $cluster

docker run -d --name store-api -p 7700:7700 -e PORT=7700 caquicode/store-api


