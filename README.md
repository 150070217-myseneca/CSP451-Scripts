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

### Output Screenshots of Azure CLI Commands

- [Network Config Screenshot](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/images/Screenshot%20(688).png)
- [VNET,Subnets Screenshot](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/images/Screenshot%20(689).png)
- [Subnet Server Creation Screenshot](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/images/Screenshot%20(690).png)
- [Details of VNET & Subnet Screenshot](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/images/Screenshot%20(692).png)
- [Creating Route Table Screenshot](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/images/Screenshot%20(693).png)
- [Route List Screenshot](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/images/Screenshot%20(694).png)
- [Association Creation Screenshot](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/images/Screenshot%20(695).png)

## Answers to the questions for this section

### 1. What does if [[ ! $(az group list -o tsv --query "[?name=='$RG_NAME']") ]] do? Explain your answer.

#### Command Breakdown

### `az group list -o tsv --query "[?name=='$RG_NAME']"`:

- **`az group list`**: This Azure CLI command lists all resource groups in the current subscription.
- **`-o tsv`**: This option specifies that the output should be in tab-separated values (TSV) format, which is easier to process in scripts.
- **`--query "[?name=='$RG_NAME']"`**:
  - **`[?name=='$RG_NAME']`**: This is a JMESPath query that filters the resource groups list to find any group with a name that matches the value of the `RG_NAME` variable.
  - If a matching resource group is found, its details are included in the output. If not, the output is empty.

### `if [[ ! $(...) ]]`:

- **`$(...)`**: This syntax is called command substitution. It runs the command inside the parentheses and substitutes its output in place.
- **`[[ ! ... ]]`**: This is a conditional test in Bash that checks if the output of the command is empty (i.e., the resource group does not exist).
- The `!` negates the condition, so `[[ ! $(...) ]]` is true if the command's output is empty.

## Explanation

- **Purpose**: The script checks if the resource group specified by `RG_NAME` exists in the current Azure subscription.
- **Logic**:
  - If the output of `az group list -o tsv --query "[?name=='$RG_NAME']"` is empty, it means no resource group with the name `RG_NAME` exists.
  - The `[[ ! ... ]]` test will be true in this case, leading to the script printing a message that the resource group doesn't exist and aborting with an exit status of 3.
  - If the resource group does exist, the script will print a message indicating that the resource group exists and then list all resource groups in a table format.

### 2. Why is it Crucial to Check if a Resource Exists Before Creating it?

Checking if a resource exists before creating it is crucial for several reasons:

- **Avoiding Duplicate Resources**: Creating a resource that already exists can lead to conflicts and unexpected behavior in your infrastructure.
- **Resource Limits**: Cloud providers often have limits on the number of certain resources you can create. Checking beforehand helps manage these limits.
- **Cost Management**: Unnecessary resource creation can lead to increased costs. Checking for existing resources helps avoid this.
- **Error Handling**: It simplifies error handling and makes the script more robust by preventing operations that would fail if the resource already exists.

### Bash Syntax to Test if a Resource Exists

In Bash, you can use the `if` statement combined with command substitution to check if a resource exists. The general syntax is:

#### bash
if [[ $(command) ]]; then
    # Resource exists
else
    # Resource does not exist
fi


### 3. What is the Azure CLI command to create vnet?

#### Command Breakdown
To create a virtual network (VNet) in Azure using the Azure CLI, you can use the `az network vnet create` command. Below is the specific command according to the given environment and unique ID configuration.

#### Specific Command
#### bash
az network vnet create -g $RG_NAME \
      --name $Router_vnet_name \
      --location $LOCATION \
      --address-prefix $Router_vnet_address

### Required Parameters
- `-g` or `--resource-group`: Specifies the resource group in which the VNet will be created. In this case, it is `$RG_NAME`.
- `--name`: Specifies the name of the VNet to be created. In this case, it is `$Router_vnet_name`.
- `--location`: Specifies the Azure region where the VNet will be created. In this case, it is `$LOCATION`.
- `--address-prefix`: Specifies the address space for the VNet in CIDR notation. In this case, it is `$Router_vnet_address`.

### Optional Parameters
- `--tags`: Tags to associate with the VNet, specified as key-value pairs (e.g., `--tags key1=value1 key2=value2`).
- `--dns-servers`: A space-separated list of DNS server IP addresses. If not provided, Azure's default DNS server is used.
- `--subnet-name`: Name of the first subnet in the VNet. If not provided, a default subnet is created.
- `--subnet-prefix`: Address prefix for the first subnet. If not provided, a default prefix is used.
- `--ddos-protection`: Specifies if DDoS protection is enabled for the VNet. Default is false.
- `--vm-protection`: Specifies if VM protection is enabled for the VNet. Default is false.

### 4. What is the Azure CLI command to create a subnet?

#### Command
#### sh
az network vnet subnet create \
  --name $subnet_name \
  --vnet-name $vnet \
  --resource-group $RG_NAME \
  --address-prefix $subnet_prefix

  ### Required Parameters
- `--name`: Specifies the name of the subnet to be created. In this case, it is $subnet_name.
- `--vnet-name`: Specifies the name of the virtual network (VNet) where the subnet will be created. In this case, it is `$vnet`.
- `--resource-group`: Specifies the resource group in which the VNet is located. In this case, it is `$RG_NAME`.
- `--address-prefix`: Specifies the address prefix for the subnet in CIDR notation. In this case, it is `$subnet_prefix`.

### Optional Parameters
- `--network-security-group`: Specifies the name or ID of a network security group to associate with the subnet.
- `--route-table`: Specifies the name or ID of a route table to associate with the subnet.
- `--service-endpoints`: Specifies a list of services to which the subnet should have service endpoints.
- `--delegations`: Specifies a list of delegations to assign to the subnet.
- `--disable-private-endpoint-network-policies`: Disable network policies for private endpoints in the subnet.
- `--disable-private-link-service-network-policies`: Disable network policies for private link service in the subnet.
- `--nat-gateway`: Specifies the name or ID of a NAT gateway to associate with the subnet.

## Part B - Working with Azure CLI Bash

### 1. List all VNETs using az network vnet list command

- [VNETs](PART_B/vnet_list.json) - .json file

### 2. Get the details of student vnet using az show

- [Student_vnet](PART_B/student_vnet.json) - .json file

### 3. List all peerings using az network vnet

- [Student_vnet](PART_B/peerings.tbl) - .tbl file

### 4. Get the details of Router-11 subnet SN1 using az show
### bash
az network vnet subnet show --resource-group Student-RG-1344553 --vnet-name Router-11 --name SN1 --query '{Name: name, AddressPrefix: addressPrefix, RouteTable: routeTable.id}' -o json
### Output
{
    "Name": "SN1",
    "AddressPrefix": "192.168.11.0/27",
    "RouteTable": "/subscriptions/7a55cf95-4c85-4bde-8a60-298d6b85d26d/resourceGroups/Student-RG-1344553/providers/Microsoft.Network/routeTables/RT-11"
}

### 5. List all routes in RT-11

- [List of all routes in RT-11](PART_B/route_list.tbl) - .tbl file

### 6. Get the details of route between Router-11 SN1 and Server-11 SN1

- [Details of Route](PART_B/route_table_routes.json) - .json file

### 7. What CLI command will show you which subnet is associated with which route in the route table?

### bash
az network route-table route list --resource-group Student-RG-1344553 --route-table-name RT-11
