#!/bin/bash

#Declare variables
rgName="LabResourceGroup"
location="westus"
VNetName="LabVNet"
subnetName="LabSubnet"
VMName="LabVM"
image="Win2016Datacenter"

#Check if the resouce group already exist
if [ "az group exists --name $rgName" = true ];
    then 
        echo $rgName "already exists. Exiting script"
        exit
    else
        #create the resource group
        az group create \
        --name $rgName \
        --location $location
fi

#Create a Vnet and subnet
az network vnet create \
--resource-group $rgName \
--name $VNetName \
--address-prefix 10.0.0.0/16 \
--location $location \
--subnet-name $subnetName \
--subnet-prefix 10.0.0.0/24

#Create a virtual machine
az vm create \
--name $VMName \
--resource-group $rgName \
--image $image \
--computer-name azlabcomputer \
--admin-username labadmin \
--admin-password p@ssw0rd123! \


#Open RDP port
az vm open-port \
--port 3389 \
--resource-group $rgName \
--name $VMName

#Show the public IP for the VM
az vm list list-ip-addresses --output table
