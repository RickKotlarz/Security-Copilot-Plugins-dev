### Palo Alto XSOAR v3 plugin (Updated 2025-March-25)

Welcome to the Palo Alto XSOAR plugin. This plugin is an example of leveraging the Palo Alto XSOAR API but does require modification from the user to function correctly.

Note this is a work in progress and these 3 skills are meant to serve as a starting point for additional development.

### Instructions
#### Upload the Custom Plugin

1. Download both plugin files (`Palo_Alto_XSOAR_template_OAPI.yaml` and `Palo_Alto_XSOAR_manifest.yaml`) from this directory
2. Edit the `Palo_Alto_XSOAR_template_OAPI.yaml` file and update the API endpoint (line 12) with your Palo Alto XSOAR API endpoint.
3. Edit the `Palo_Alto_XSOAR_template_OAPI.yaml` file and update the API key ID (line 34) denoted as 'default: 1234'.
4. Upload the `Palo_Alto_XSOAR_template_OAPI.yaml` file to a public resource (e.g. GitHub) and copy the raw source URL (Hint: You can find this by selecting the `Raw` button at the top right corner of the GitHub page.)
5. Edit the `Palo_Alto_XSOAR_manifest.yaml` file and update the `OpenApiSpecUrl` with the raw URL (line 24).
6. Install the plugin within Security Copilot by either uploading the `Palo_Alto_XSOAR_manifest.yaml` file or referencing the raw source URL for the `Palo_Alto_XSOAR_manifest.yaml` file 

#### Utlization of the plugin:

- **X-GetIncident** - Gets a specific incident
- **X-GetAllDashboardDetails** - Gets all dashboards details
- **X-GetDashboardDetails** - Gets details for specefic dashboard


[Swagger documentation reference](https://swagger.io/docs/specification/v3_0/authentication/)
