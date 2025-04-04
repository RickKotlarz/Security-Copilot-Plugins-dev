# Author: Amit Singh & GPT-4o
#
### Step 1: Get the Service Principal ID

Replace `<EnterpriseAppDisplayName>` with your app's display name to retrieve its service principal ID:

PowerShell:
```
$ServicePrincipal = Get-MgServicePrincipal -Filter "displayName eq '<EnterpriseAppDisplayName>'"
$ServicePrincipalId = $ServicePrincipal.Id
```

### Step 2: Find App Role IDs for Each Permission
For each API (Microsoft Graph and WindowsDefenderATP), find the required `AppRole` IDs.  You can query the roles using:

PowerShell for the Microsoft Graph:
```
$GraphApp = Get-MgServicePrincipal -Filter "appId eq '00000003-0000-0000-c000-000000000000'" # Microsoft Graph App ID
$GraphApp.AppRoles | Where-Object { $_.Value -in "Device.Read.All", "User.Read.All" }
```

PowerShell for the WindowsDefenderATP:
```
$DefenderApp = Get-MgServicePrincipal -Filter "appId eq 'fc780465-2017-40d4-a0c5-307022471b92'" # WindowsDefenderATP App ID
$DefenderApp.AppRoles | Where-Object { $_.Value -in "SecurityRecommendation.Read.All", "Machine.Read.All" }
```

Record the `Id` property for each role found, as these are the IDs needed for assignment.

### Step 3: Assign Permissions to the Enterprise App with Admin Consent

With `$ServicePrincipalId` set and role IDs retrieved, assign each role: 

PowerShell to assign Microsoft Graph permissions:
```
New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipalId -PrincipalId $ServicePrincipalId -AppRoleId "<Device.Read.All_RoleId>" -ResourceId $GraphApp.Id
New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipalId -PrincipalId $ServicePrincipalId -AppRoleId "<User.Read.All_RoleId>" -ResourceId $GraphApp.Id
```

PowerShell to assign WindowsDefenderATP permissions:
```
New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipalId -PrincipalId $ServicePrincipalId -AppRoleId "<SecurityRecommendation.Read.All_RoleId>" -ResourceId $DefenderApp.Id
New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipalId -PrincipalId $ServicePrincipalId -AppRoleId "<Machine.Read.All_RoleId>" -ResourceId $DefenderApp.Id
```

### Notes
- Replace each `AppRoleId` placeholder with the ID of the respective permission.
- Ensure you have appropriate admin privileges to grant permissions with admin consent.

This should configure your enterprise app with the specified permissions and admin consent. Let me know if you run into any issues!

### Examples:

#### Assign Microsoft Graph permissions
`New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipalId -PrincipalId $ServicePrincipalId -AppRoleId "7438b122-aefc-4978-80ed-43db9fcc7715" -ResourceId $GraphApp.Id`

`New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipalId -PrincipalId $ServicePrincipalId -AppRoleId "df021288-bdef-4463-88db-98f22de89214" -ResourceId $GraphApp.Id`

#### Assign WindowsDefenderATP permissions
`New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipalId -PrincipalId $ServicePrincipalId -AppRoleId "6443965c-7dd2-4cfd-b38f-bb7772bee163" -ResourceId $DefenderApp.Id`

`New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $ServicePrincipalId -PrincipalId $ServicePrincipalId -AppRoleId "ea8291d3-4b9a-44b5-bc3a-6cea3026dc79" -ResourceId $DefenderApp.Id`
