#1 Connecting to Azure account
Add-AzAccount

#2 Creating a credential to azure account
$cred = $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'dbuser', $(ConvertTo-SecureString -String 'Tlaphbc@1' -AsPlainText -Force))

#3 Creating a resource group
New-AzResourceGroup -Name training -Location 'West US'
$parameters = @{
    ResourceGroupName = 'training'
    ServerName = 'trainserv1'
    Location = 'West US'
    SqlAdministratorCredentials = $cred
}
New-AzSqlServer @parameters

#4 Creating a logical server and firewall access
$parameters = @{
    ResourceGroupName = 'training'
    ServerName = 'trainserv1'
    FirewallRuleName = 'AllowedIps'
    StartIpAddress = '90.52.105.3'
    EndIpAddress = '136.52.105.3'
}
New-AzSqlServerFirewallRule @parameters

#5 Creating a database with pricing tier
$parameters = @{
    ResourceGroupName = 'training'
    ServerName = 'trainserv1'
   DatabaseName = 'azuresqldb1'
   RequestedServiceObjectiveName = 'BASIC'
}
New-AzSqlDatabase @parameters
