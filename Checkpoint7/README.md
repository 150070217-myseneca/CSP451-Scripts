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
![Association Creation Screenshot](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/images/Screenshot%20(695).png)

## Answers to the questions for this section

#### 1. What does if [[ ! $(az group list -o tsv --query "[?name=='$RG_NAME']") ]] do? Explain your answer.

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

#### 2. Why is it Crucial to Check if a Resource Exists Before Creating it?

Checking if a resource exists before creating it is crucial for several reasons:

- **Avoiding Duplicate Resources**: Creating a resource that already exists can lead to conflicts and unexpected behavior in your infrastructure.
- **Resource Limits**: Cloud providers often have limits on the number of certain resources you can create. Checking beforehand helps manage these limits.
- **Cost Management**: Unnecessary resource creation can lead to increased costs. Checking for existing resources helps avoid this.
- **Error Handling**: It simplifies error handling and makes the script more robust by preventing operations that would fail if the resource already exists.

### Bash Syntax to Test if a Resource Exists

In Bash, you can use the `if` statement combined with command substitution to check if a resource exists. The general syntax is:

```bash
if [[ $(command) ]]; then
    # Resource exists
else
    # Resource does not exist

```


#### 3. What is the Azure CLI command to create vnet?

#### Command Breakdown
- To create a virtual network (VNet) in Azure using the Azure CLI, you can use the `az network vnet create` command. Below is the specific command according to the given environment and unique ID configuration.

#### Specific Command
```bash
az network vnet create -g $RG_NAME \
      --name $Router_vnet_name \
      --location $LOCATION \
      --address-prefix $Router_vnet_address
```
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

#### 4. What is the Azure CLI command to create a subnet?

#### Command
```bash
az network vnet subnet create \
  --name $subnet_name \
  --vnet-name $vnet \
  --resource-group $RG_NAME \
  --address-prefix $subnet_prefix
```
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

#### 1. List all VNETs using az network vnet list command

- [VNETs](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_B/vnet_list.json) - .json file

#### 2. Get the details of student vnet using az show

- [Student_vnet](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_B/student_vnet.json) - .json file

#### 3. List all peerings using az network vnet

- [Student_vnet](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_B/peerings.tbl) - .tbl file

#### 4. Get the details of Router-11 subnet SN1 using az show
```bash
az network vnet subnet show --resource-group Student-RG-1344553 --vnet-name Router-11 --name SN1 --query '{Name: name, AddressPrefix: addressPrefix, RouteTable: routeTable.id}' -o json
```
### Output
```json
{
    "Name": "SN1",
    "AddressPrefix": "192.168.11.0/27",
    "RouteTable": "/subscriptions/7a55cf95-4c85-4bde-8a60-298d6b85d26d/resourceGroups/Student-RG-1344553/providers/Microsoft.Network/routeTables/RT-11"
}
```

#### 5. List all routes in RT-11

- [List of all routes in RT-11](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_B/route_list.tbl) - .tbl file

#### 6. Get the details of route between Router-11 SN1 and Server-11 SN1

- [Details of Route](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_B/route_table_routes.json) - .json file

#### 7. What CLI command will show you which subnet is associated with which route in the route table?

```bash
az network route-table route list --resource-group Student-RG-1344553 --route-table-name RT-11
```

## Part C - Creating Virtual Machines using Azure CLI

#### 1. List all VMs and send the output in table. What command did you use?

- To list all VMs in the resource group `Student-RG-1344553` and save the output in table format to `vm_list.tbl`, use the following command:

```bash
az vm list --resource-group Student-RG-1344553 --output table > vm_list.tbl
```

- [vm_list](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_C/vm_list.tbl) - .tbl file


#### 2. Get the details of `WC-11` using `az show` command and send the output. What command did you use?

- To get the details of the virtual machine `WC-11` in the resource group `Student-RG-1344553` and save the output in JSON format to `WC-11-details.json`, use the following command:

```bash
az vm show --resource-group Student-RG-1344553 --name WC-11 --output json > WC-11-details.json
```

- [WC-11-details](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_C/WC-11-details.json) - .json file

#### 3. List all NSG using `az list` command and send the output . What command did you use?

- To list all Network Security Groups (NSGs) and save the output in table format to `nsg_list.tbl`, use the following command:

```bash
az network nsg list --output table > nsg_list.tbl
```

- [nsg_list](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_C/nsg_list.tbl) - .tbl file

#### 4. What is the time-zone? What should be the correct time settings considering the time zone differences?

- Standard Time (EST): 12:00 midnight EST corresponds to 05:00 UTC.
- During Daylight Saving Time (EDT): Set the auto-shutdown time to 04:00 UTC. 

![Screenshot of ``auto shutdown configuration``](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_C/Screenshot%20(700).png)

#### 5. For `auto shutdown configuration` is it possible to configure auto shutdown while you are creating the VM?

- Yes, it is possible to configure auto-shutdown while creating a VM in Azure using Azure Resource Manager (ARM) templates, PowerShell scripts, Azure CLI commands, or through the Azure portal. This capability allows you to specify the auto-shutdown schedule during the initial VM creation process


## Part D - Creating Custome Images from VMs using Azure CLI

#### 1. What is the difference between the script that creates a VM from Azure Generic Image and Custome Image?

- Image Source (--image parameter):

    - Custom Image Script: Uses a dynamically constructed image name ($image_name) based on the VM name and a target version.
    - Generic Image Script: Specifies a predefined image name ($VM_IMG_WC, $VM_IMG_WS, etc.) for each VM.

- VM Creation Logic:

    - Both scripts check if the VM already exists before attempting to create it, ensuring no duplicate VMs are created unintentionally.
    - Custom Image Script: Additionally retrieves the image ID ($image_id) and displays VM creation status.

These differences highlight how each script manages the image source and creation process, catering to specific needs for customizing VM creation from Azure images.


#### 2. What is the usage suggestion?

  ---------------------------------------------------
  target_version parameter not provided
  Usage: ./image_create.sh <target_version>
  ---------------------------------------------------

#### 3. How can you parallelize the process?

- To parallelize the creation of custom images in script, we can modify the function calls to run asynchronously in the background.

- [custom_image_create.sh](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/bash-scripts/custom_image_create.sh) - Script for custom image creation in Azure.

- Each call to custom_image_create is followed by & which puts the function call in the background.
- The wait command is used to wait for all background jobs to finish before proceeding to list the images.

#### 4. The output format to table format

- [Custome Images Table](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_D/custom_images_table.tbl) - .tbl file

#### 4. Which ones are empty?

- [VM Table](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_D/vm_table.tbl) - .tbl file
- [NSG Table](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_D/nsg_table.tbl  ) - .tbl file
- [NIC Table](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_D/nic_table.tbl) - .tbl file
- [Disks Table](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_D/disk_table.tbl) - .tbl file
- [Custome Images Table](https://github.com/150070217-myseneca/CSP451-Scripts/blob/main/Checkpoint7/assets/PART_D/custom_images_table.tbl) - .tbl file

#### * Nothing in empty

## Part E - Clean Up your Environment using Azure CLI

#### 1. Deleting all your VMs.

 **Confirm VM Deletion:**

   - After executing the deletion command, verify using the Azure CLI command:
     ```bash
     az vm list --output table > delete_vm_list.tbl
     ```
     This command lists all VMs currently present in the Azure subscription in a table format.

   - If the output shows no VMs, it confirms that all VMs have been successfully deleted.

   - - [Deleted VM Table]() - .tbl file

- By following these steps, you can ensure that all VMs are deleted from your Azure subscription and verify their deletion using Azure CLI commands.


#### 2. Why are you not asked to delete Custome Images?

 **Difference in Cost Implications**

   - VMs have active OS disks that contribute significantly to compute costs. These costs include CPU, memory, and associated Azure services while the VM is running.

   - Custom Images, on the other hand, are essentially dormant snapshots stored as VHDs. They incur minimal storage costs for their existence but do not consume compute resources or contribute to ongoing costs related to VM runtime.


#### 3. What are the cost implications of NSG or NIC? Why are you deleting them?

#### NSGs (Network Security Groups):
- Costs: NSGs themselves do not incur direct costs. They are logical containers for inbound and outbound security rules that filter network traffic to and from Azure resources.
- Impact: While NSGs do not have direct costs associated with their existence, misconfigured or overly complex NSG rules can lead to inefficient network traffic handling or increased troubleshooting efforts, indirectly impacting operational costs.
#### NICs (Network Interface Cards):
- Costs: NICs in Azure VMs typically do not incur separate costs on their own. They are part of the VM's configuration and are billed as part of the VM's compute resources.
- Impact: However, unused or orphaned NICs can complicate network management and auditing processes. Properly managing NICs ensures efficient use of Azure networking resources and reduces potential security risks from misconfiguration or unauthorized access.


#### 4. Why are you not deleting the Network backend like VNET and Route-Tables?

- Network backends like VNETs and Route Tables are critical components of Azure infrastructure, supporting connectivity and functionality for various resources. While they are not typically deleted outright due to their foundational role and dependencies, proactive management, regular review, and optimization are key to maintaining a secure, efficient, and well-managed Azure environment.