# CSP451-Scripts
Scripts and codes - CSP451 Computer Systems Project

# Checkpoint7 Submission

- **COURSE INFORMATION: CSP451-Project**
- **STUDENT’S NAME: Sithum Bamunuarachchi**
- **STUDENT'S NUMBER: 150070217**
- **GITHUB USER ID: Sithum121**
- **TEACHER’S NAME: Atoosa Nasiri**

## Part A - Creating Network Resources using Azure CLI

### network_config.sh

- [network_config.sh](bash-scripts/network_config.sh) - Script for configuring network resources in Azure.
- [network_setup.sh](scripts/network_setup.sh) - Script for setting up virtual networks and subnets.
- [route_table_setup.sh](scripts/route_table_setup.sh) - Script for creating route tables and routes.

### Output of Azure CLI Commands

#### Virtual Networks

| Resource Group          | Virtual Network Name     | Address Space    | Subnets                                  |
|-------------------------|--------------------------|------------------|------------------------------------------|
| Student-RG-1344553      | Student-1344553-vnet     | 10.1.0.0/16      | Virtual-Desktop-Client (10.1.1.0/24)     |
| Student-RG-1344553      | Server-11                | 172.17.11.0/24   | SN1 (172.17.11.0/27)                     |
| Student-RG-1344553      | Router-11                | 192.168.11.0/24  | SN1 (192.168.11.0/27)                    |

#### Route Tables

| Resource Group          | Route Table Name | Routes                               | Associated Subnets                         |
|-------------------------|------------------|--------------------------------------|--------------------------------------------|
| Student-RG-1344553      | RT-11            | Route-to-Server (172.17.11.0/27)     | Server-11/SN1                             |
| Student-RG-1344553      | RT-11            | Route-to-Client (10.1.1.0/24)        | Student-1344553-vnet/Virtual-Desktop-Client|
