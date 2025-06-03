#Step 1. Create an automation account with a self managed identity. For security reasons use a private endpoint, but we aren't going to use it.
#Step 2. Assign that automation account contributor roles to the resource groups where the SCUs reside or grant that automation account contributor rights to all subscriptions.
#Step 3. Create a new runbook and copy / paste the below script
#Step 4. Assign a schedule within the runbook to execute daily

az login --identity
Write-output "Finding all SCUs within the tenant"

$subscriptions = az account list --query "[].id" -o tsv
$results = @()

foreach ($subscription in $subscriptions) {
    $resources = az resource list --subscription $subscription --query "[?contains(type, 'Microsoft.SecurityCopilot/capacities')].{SubscriptionId:'$subscription', ResourceId:id, ResourceName:name, ResourceGroup:resourceGroup, ResourceProviderType:type}" -o json
    $results += $resources | ConvertFrom-Json
}

Write-output "Setting variables for each entity"
$SubscriptionId = $results | ForEach-Object { $_.SubscriptionId }
$ResourceId = $results | ForEach-Object { $_.ResourceId }
$ResourceName = $results | ForEach-Object { $_.ResourceName }
$ResourceGroup = $results | ForEach-Object { $_.ResourceGroup }
$ResourceProviderType = $results | ForEach-Object { $_.ResourceProviderType }


$results | Format-Table -Property SubscriptionId, ResourceName, ResourceGroup, ResourceProviderType
Write-output $results


if ([string]::IsNullOrEmpty($ResourceId)) {
    Write-Output "No SCUs found within the tenant"
} else {
    az resource delete --ids $ResourceId
    Write-Output "Resource with ID $ResourceId has been deleted."
}