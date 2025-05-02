# Monitoring and troubelshooting Security Copilot

### Get Security Copilot logs - Requires Defender for Cloud CloudAppEvents
```
let recordTypeLookup = datatable(RecordType:int, PurviewAuditRecordType:string)
[
    100, "CopilotforSecurity",
    261, "CopilotInteraction",
    310, "CreateCopilotPlugin",
    311, "UpdateCopilotPlugin",
    312, "DeleteCopilotPlugin",
    313, "EnableCopilotPlugin",
    314, "DisableCopilotPlugin",
    315, "CreateCopilotWorkspace",
    316, "UpdateCopilotWorkspace",
    317, "DeleteCopilotWorkspace",
    318, "EnableCopilotWorkspace",
    319, "DisableCopilotWorkspace",
    320, "CreateCopilotPromptBook",
    321, "UpdateCopilotPromptBook",
    322, "DeleteCopilotPromptBook",
    323, "EnableCopilotPromptBook",
    324, "DisableCopilotPromptBook",
    325, "UpdateCopilotSettings",
    363, "CopilotActions"
];
CloudAppEvents
| where TimeGenerated >= ago(24h)
| extend eventData = parse_json(RawEventData)
| where tostring(eventData.AppIdentity) contains "Copilot.Security.SecurityCopilot"
| extend 
    ClientIP = tostring(eventData.ClientIP),
    Id = tostring(eventData.Id),
    Operation = tostring(eventData.Operation),
    RecordType = toint(eventData.RecordType),
    UserId = tostring(eventData.UserId),
    CopilotEventData = parse_json(eventData.CopilotEventData)
| extend 
    AppHost = tostring(CopilotEventData.AppHost),
    SessionId = tostring(CopilotEventData.CorrelationId),
    IsPrompt = tostring(CopilotEventData.Messages[0].isPrompt)
| extend PromptType = case(
    IsPrompt == "true", "Standalone",
    IsPrompt == "false", "Embedded",
    "")
| extend SecurityCopilotRBACtype = case(
        AccountType == "Regular", "Contributor",
        AccountType == "Admin", "Owner",
        "")
| join kind=leftouter recordTypeLookup on RecordType
| extend CopilotExperience = AppHost
| project SessionId, TimeGenerated, SecurityCopilotRBACtype, UserId, CopilotExperience, PromptType, PurviewAuditRecordType, ClientIP
| take 25
```

### Search for "Security Copilot" within the CloudAppEvents table
```
CloudAppEvents
| where TimeGenerated >= ago(24h)
| search "Security Copilot"
```

### Returns rows related to Security Copilot within the CloudAppEvents table
```
CloudAppEvents
| where parse_json(RawEventData)["AppIdentity"] == 'Copilot.Security.SecurityCopilot'
| where parse_json(RawEventData)["Workload"] == 'Copilot'
```

### Queries the resourcechanges table within the Azure Resource Graph to show changes to resources that related to Security Copilot.
```
arg("").resourcechanges 
| extend timestamp = todatetime(properties["changeAttributes"]["timestamp"])
| extend changes = properties["changes"]
| extend ResourceId = tostring(properties["targetResourceId"])
| extend CorrelationId = tostring(properties["changeAttributes"]["correlationId"])
| extend targetResourceType = tostring(properties["targetResourceType"])  // Expand the targetResourceType field
| where timestamp >= ago(30d)
| where targetResourceType contains "microsoft.securitycopilot"  // Filter by substring in targetResourceType to identify Security Copilot
```

### Shows the API GET/POST activity for Graph API related to Security Copilot
```
MicrosoftGraphActivityLogs
            //| where TimeGenerated > ago({{timeframe}})
            //| where Scopes contains "{{apipermissionscope}}""
            //| where RequestMethod == "POST" // Only API calls initiated by plugins or Logic Apps
            | where UserAgent contains "MicrosoftCopilotforSecurity" 
            //or UserAgent contains "azure-logic-apps"
            | where isnotempty(UserId)
            | join kind=inner (
                IdentityInfo
                | where TimeGenerated > ago(30d)
                | summarize arg_max(TimeGenerated, *) by AccountObjectId
                | project UserId=AccountObjectId
            ) on UserId
            | project-away UserId1
            | extend GeoIPInfo = geo_info_from_ip_address(IPAddress)
            | extend country = tostring(parse_json(GeoIPInfo).country),
                     state = tostring(parse_json(GeoIPInfo).state),
                     city = tostring(parse_json(GeoIPInfo).city),
                     latitude = todouble(parse_json(GeoIPInfo).latitude),
                     longitude = todouble(parse_json(GeoIPInfo).longitude)
            | project TimeGenerated, country, state, city, latitude, longitude, ApiVersion, RequestMethod, ResponseStatusCode, IPAddress, UserAgent, RequestUri, UserId, Scopes
            | limit 100
```

---

# Sentinel / Defender alert coorelation queries

### Get alerts from various Microsoft products
```
AlertEvidence
| where ServiceSource contains "Insider Risk Management" or 
        ServiceSource contains "Data Loss Prevention" or
        ServiceSource contains "AAD Identity Protection" or
        ServiceSource contains "Microsoft Defender for Cloud" or
        ServiceSource contains "Microsoft Defender for Cloud Apps" or
        ServiceSource contains "App Governance" or
        ServiceSource contains "Microsoft Defender for Office 365" or
        ServiceSource contains "Microsoft Defender for Identity"
| take 10
```

### Get incidents from various Microsoft products
```
SecurityIncident
| extend AdditionalDataParsed = parse_json(AdditionalData)
| where tostring(AdditionalDataParsed.alertProductNames) contains "Azure Sentinel" or
        tostring(AdditionalDataParsed.alertProductNames) contains "Microsoft Defender Advanced Threat Protection" or
        tostring(AdditionalDataParsed.alertProductNames) contains "Microsoft 365 Defender" or
        tostring(AdditionalDataParsed.alertProductNames) contains "Microsoft Data Loss Prevention" or
        tostring(AdditionalDataParsed.alertProductNames) contains "Azure Active Directory Identity Protection" or
        tostring(AdditionalDataParsed.alertProductNames) contains "Microsoft 365 Insider Risk Management" or
        tostring(AdditionalDataParsed.alertProductNames) contains "MicrosoftInsiderRiskManagement" or
        tostring(AdditionalDataParsed.alertProductNames) contains "Azure Advanced Threat Protection" or
        tostring(AdditionalDataParsed.alertProductNames) contains "Office 365 Advanced Threat Protection" or
        tostring(AdditionalDataParsed.alertProductNames) contains "Azure Security Center" or
        tostring(AdditionalDataParsed.alertProductNames) contains "Azure Security Center for IoT" or
        tostring(AdditionalDataParsed.alertProductNames) contains "Microsoft Cloud App Security"
| take 10
```

### SecurityIncident - Incident table for Defender, Sentinel and other products
// [https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/securityincident](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/securityincident)
```
SecurityIncident
| take 4
```

### Alerts that been generated by security products (Sentinel, Defender and others) and sent here
[https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/securityalert](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/securityalert)
```
SecurityAlert
| take 4
```

### Alerts from Microsoft Defender for Endpoint, Microsoft Defender for Office 365, Microsoft Cloud App Security, and Microsoft Defender for Identity
[https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/AlertEvidence](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/AlertEvidence)
```
AlertEvidence
| take 4
```

### AlertInfo - Not very useful...
Alerts from Microsoft Defender for Endpoint, Microsoft Defender for Office 365, Microsoft Cloud App Security, and Microsoft Defender for Identity
[https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/alertinfo](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/alertinfo)
```
AlertInfo
| take 4
```

---

## Basic KQL

### Shows the top 10 rows of the 'DeviceNetworkInfo' table
```
DeviceNetworkInfo
| limit 10 
```

### Searches for a string and shows the distint tables where thatls lcoated
```
search "Disable 'Always install with elevated privileges'"
| distinct $table
```

### Gets all tables that are being logged. This is useful during troubleshooting.
```
search *
| distinct $table
```

### Searches for the string "alpine" in the SigninLogs table then returns a distinct Location for each row in the response. 
```
SigninLogs
| search "alpine"
| distinct Location
```

### Get the KQL schema for a table (SigninLogs)
```
SigninLogs
| getschema
```

### Basic Hello World use case
```
let greeting = 'Hello world';
print greeting
```

### Shows the Sentinel free billing tables
```
Usage
| where IsBillable == false
| summarize by DataType, IsBillable
```
