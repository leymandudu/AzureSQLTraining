#1 Define a variable with a unique resource group name.
$ResourceGroupName = "sqlvm1"
$Location = "North Europe"
New-AzResourceGroup -Name $ResourceGroupName -Location $Location

#2 Create a virtual network, subnet, and a public IP address. These resources are used to provide network 
# connectivity to the virtual machine and connect it to the internet.
$SubnetName = $ResourceGroupName + "subnet"
$VnetName = $ResourceGroupName + "vnet"
$PipName = $ResourceGroupName + $(Get-Random)

# Create a subnet configuration
$SubnetConfig = New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix 192.168.1.0/24

# Create a virtual network
$Vnet = New-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Location $Location `
   -Name $VnetName -AddressPrefix 192.168.0.0/16 -Subnet $SubnetConfig

# Create a public IP address and specify a DNS name
$Pip = New-AzPublicIpAddress -ResourceGroupName $ResourceGroupName -Location $Location `
   -AllocationMethod Static -IdleTimeoutInMinutes 4 -Name $PipName

# Rule to allow remote desktop (RDP)
$NsgRuleRDP = New-AzNetworkSecurityRuleConfig -Name "RDPRule" -Protocol Tcp `
   -Direction Inbound -Priority 1000 -SourceAddressPrefix * -SourcePortRange * `
   -DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow

#Rule to allow SQL Server connections on port 1433
$NsgRuleSQL = New-AzNetworkSecurityRuleConfig -Name "MSSQLRule"  -Protocol Tcp `
   -Direction Inbound -Priority 1001 -SourceAddressPrefix * -SourcePortRange * `
   -DestinationAddressPrefix * -DestinationPortRange 1433 -Access Allow

# Create the network security group
$NsgName = $ResourceGroupName + "nsg"
$Nsg = New-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName `
   -Location $Location -Name $NsgName `
   -SecurityRules $NsgRuleRDP,$NsgRuleSQL
#3
$InterfaceName = $ResourceGroupName + "int"
$Interface = New-AzNetworkInterface -Name $InterfaceName `
   -ResourceGroupName $ResourceGroupName -Location $Location `
   -SubnetId $VNet.Subnets[0].Id -PublicIpAddressId $Pip.Id `
   -NetworkSecurityGroupId $Nsg.Id

#4 Define your credentials to sign in to the VM. The username is "dbuser". Make sure you change 
#4 <password> before running the command.

# Define a credential object
$SecurePassword = ConvertTo-SecureString 'Tlaphbc@1' `
   -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential ("dbuser", $securePassword)

# Create a virtual machine configuration
$VMName = $ResourceGroupName + "VM"
$VMConfig = New-AzVMConfig -VMName $VMName -VMSize Standard_D2as_v4 |
   Set-AzVMOperatingSystem -Windows -ComputerName $VMName -Credential $Cred -ProvisionVMAgent -EnableAutoUpdate |
   Set-AzVMSourceImage -PublisherName "MicrosoftSQLServer" -Offer "SQL2017-WS2016" -Skus "SQLDEV" -Version "latest" |
   Add-AzVMNetworkInterface -Id $Interface.Id

# Create the VM
New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VMConfig


#7 Use the following command to retrieve the public IP address for the new VM.
Get-AzPublicIpAddress -ResourceGroupName $ResourceGroupName | Select IpAddress

# This line pause the process for 20 seconds.
Start-Sleep -Seconds 20 # This line will make the code to wait/pause for 20 seconds

#8 Pass the returned IP address as a command-line parameter to mstsc to start a Remote Desktop session 
#8 into the new VM.
# mstsc /v:104.42.58.60
# mstsc /v:Read-Host -Prompt "Enter your IP Address" -AsSecureString
# Connect to SQL Server via azure connect
