$resourceName = "SCU-from-Azure-shell"
$resourceGroupName = "SCU-demo-RG"
$resourceType = "microsoft.securitycopilot/capacities"
$numberOfSCUs = 1 ### base line number of SCUs
$overageState = "Limited" ### "Unlimited"
$overageAmount = 2 ### not needed if overage state is unlimited
$geoLocation = "eastus" ### "westeurope"
$geo = "US" ### "EU"
$crossGeo = "NotAllowed" ### "Allowed"

New-AzResource -ResourceName $resourceName -ResourceType $resourceType  -ResourceGroupName $resourceGroupName -Location $geoLocation -Properties @{numberOfUnits=$numberOfSCUs; overageState=$overageState; crossGeoCompute=$crossGeo; geo=$geo}
