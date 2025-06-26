################# Modify as needed #########################
$resourceName = "SCU-created-from-Azure-shell-v4"
$resourceGroupName = "SCU-demo-RG"
$resourceType = "microsoft.securitycopilot/capacities"
$numberOfSCUs = 1           ### baseline number of SCUs
$overageState = "Limited"   ### "Unlimited"
$overageAmount = 2          ### not needed if overage state is unlimited
$geoLocation = "eastus"     ### "westeurope"
$geo = "US"                 ### "EU"
$crossGeo = "Allowed"       ### "NotAllowed"
$apiVersion = "2024-11-01-preview"
$tags = @{
    Department = 'SOC'
    BillingCode = '12345'
}

######### Execute once avove has been editied ##############
New-AzResource -ResourceName $resourceName `
    -ResourceType $resourceType `
    -ResourceGroupName $resourceGroupName `
    -Location $geoLocation `
    -Properties @{
        numberOfUnits = $numberOfSCUs
        overageState = $overageState
        overageAmount = $overageAmount
        crossGeoCompute = $crossGeo
        geo = $geo
    } `
    -ApiVersion $apiVersion `
    -Tag $tags
