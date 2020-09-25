#!/bin/sh

resource_group="rgpazewdmlit-pricing-k8s-001"
subscription="Maersk Line Self-Managed Digital Cloud 01 NP ARM"
cluster=pricing-dev-west-1

az aks get-credentials --resource-group "$resource_group" --subscription "$subscription" --name $cluster