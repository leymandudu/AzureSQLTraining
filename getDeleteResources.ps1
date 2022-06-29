# Get a resource group
Get-AzResourceGroup

# Pause the process until input from user.
Read-Host -Prompt "Press any key to continue..."
# Start-Sleep -Seconds 20 # This line will make the code to wait/pause for 20 seconds
# Start-Sleep -Milliseconds 40 # This line will make the code wait/pause for 40 milliseconds


# Get all resources
Get-AzResource

# Remove resource group and all its content
# Remove-AzResourceGroup -Name #Insert ResourceGroupName

# Pause the process until input from user.
Read-Host -Prompt "Press any key to continue..."

# Remove all Resource Group
Get-AzResourceGroup | Remove-AzResourceGroup
