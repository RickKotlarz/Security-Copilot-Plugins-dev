$subscription = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
$resourceGroup = "copilot-for-security-demo"
$resourceName = "cop-prod-useast"
$resourceType = "microsoft.securitycopilot/capacities"
$numberOfSCUs = 1 ### base line number of SCUs
$overageAmount = 2 ### not needed if overage state is unlimited

Connect-AzAccount -Identity
Set-AzContext -Subscription $subscription
$resource = Get-AzResource -ResourceGroupName $resourceGroup -ResourceName $resourceName -ResourceType $resourceType
$resource.Properties.numberOfUnits = $numberOfSCUs
$resource.Properties.overageAmount = $overageAmount
$resource | Set-AzResource -Force
