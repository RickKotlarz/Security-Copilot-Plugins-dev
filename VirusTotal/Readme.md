## I don't reccomend using this plugin as it it needs to be updated for OpenAPI spec 3.0.1. 

### VirusTotal Custom Plugin V3 (Updated Sept-2024)

Welcome to the VirusTotal custom plugin! Here, you'll discover a suite of features designed to empower your malware analysis and threat intelligence efforts:
### Instructions
#### Upload the Custom Plugin

1. Obtain the file [VirusTotal_Plugin.yaml](https://raw.githubusercontent.com/RickKotlarz/Copilot-for-Security-Plugins/main/VirusTotal/VirusTotal_API_plugin_manifest.yaml) from this directory.
2. Upload the custom plugin
3. Add the Virus total API Key
#### Utlization of the plugin:

- **VT-IPReport** Assess the reputation and threat level of a provided IP addresses.

- **VT-DomainReport** Assess the reputation and threat level of a provided domain name.

- **VT-GetFileReport** Assess the reputation and threat level of a file from a provided hash.

- **VT-GetSummaryOfAllBehaviorReports** Provides a summary of all behaviors for a given file hash.

- **VT-GetSummaryOfMitreAttacksObserved** Gets a summary of Mitre attacks for a file hash.

- **VT-GetFileBehaviorReportFromSandbox** Gets a file behavior report from a sandbox using the SHA256 followed by an underscore (e.g. _ ) character and the sandbox name.

- **VT-ScanURL** Submits a URL for scanning - returns an Analysis ID.

- **VT-GetURLanalysisReport** Gets a URL analysis report.

- **VT-GetUrlIDReport** Accepts an analysis ID from ScanURL and returns the analysis report object.

- **VT-GetAttackTechObject** Gets an attack technique object.

- **VT-GetObjectsRelatedToAttackTech** Gets objects related to an attack technique.

- **VT-GetPopularThreatCats** Gets a list of popular threat categories currently observed in the wild.

- **VT-SearchForFilesURLsDomainsAndComments** Searches for files, URLs, domains, IPs and comments.
