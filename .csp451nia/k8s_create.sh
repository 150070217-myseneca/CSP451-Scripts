source ./setup_config.sh
echo -e "Loaded variabes without error"
source ./network_create.sh
echo -e "Loaded functions without error"

function kubernetes_cluster_create() {

Host1_NIC_name="host1-$ID"
Host2_NIC_name="host2-$ID"
Host3_NIC_name="host3-$ID"

Host1_VM_name="Host1-VM-$ID"
Host2_VM_name="Host2-VM-$ID"
Host3_VM_name="Host3-VM-$ID"
echo
echo -e "az network nic delete -g $RG_NAME --name $Host1_NIC_name " 
az network nic delete -g $RG_NAME --name $Host1_NIC_name 

echo
echo -e "az network nsg delete -g $RG_NAME --name $Host2_NSG_name "
az network nsg delete -g $RG_NAME --name $Host2_NSG_name

echo
echo -e "az network nsg delete -g $RG_NAME --name $Host3_NSG_name "
az network nsg delete -g $RG_NAME --name $Host3_NSG_name

host_vm_create "$Host1_VM_name" "$Host_IMG" "$Host1_NIC_name"
host_vm_create "$Host2_VM_name" "$Host_IMG" "$Host2_NIC_name"
host_vm_create "$Host3_VM_name" "$Host_IMG" "$Host3_NIC_name"

configure_auto_shutdown "$Host1_VM_name"
configure_auto_shutdown "$Host2_VM_name"
configure_auto_shutdown "$Host3_VM_name"
}