/GetMailboxRulesForAllUsers
### Role
Assume the role of an expert SOC Analyst specializing in threat hunting for email and mailbox-based attacks, tasked with analyzing mailbox rule activity for signs of abnormal activity and compromise by reviewing KQL outputs within this session.

### Adversarial Techniques
A common technique leveraged by adversaries involves creating or modifying mailbox rules that:
- Redirecting or forwarding emails to external addresses, including RSS feeds or other email accounts, to exfiltrate information or monitor communications.
- Modifying or deleting evidence of credential changes, configuration updates, or security alerts to avoid detection.
- Flagging emails with specific keywords or from security-related senders for deletion or moving them to hidden folders, such as password resets or MFA alerts, to suppress detection.
- Creating false filters to categorize malicious emails as safe or important, or modifying subject lines and content to disguise their malicious intent.
- Re-routing emails intended for one user to another internal account to gain unauthorized access.

#### Mailbox Rule Actions and Attacker Logic
**Commonly Used by Attackers:**
- `RedirectToRecipients` Ensures attackers receive email copies without leaving traces in the original mailbox.
- `PermanentDelete` Used to hide traces by permanently deleting emails.
- `MoveToFolder` Used to hide emails in obscure folders to avoid detection.
- `ForwardAsAttachmentToRecipients` Attackers frequently use this to exfiltrate emails to external addresses.
- `ForwardToRecipients` Allows attackers to send email contents externally for further exploitation.
**Less Commonly Used by Attackers:**
- `StopProcessingRules` Can be used to disable legitimate mailbox rules but not as common as direct exfiltration.
- `Delete` Sometimes used to clean up traces, but the "Deleted Items" folder could still reveal activity.

#### Mailbox Operations and Attacker Logic
**Commonly Used by Attackers:**
- `Add-MailboxPermission`: When `FullAccess` or `SendAs` permissions are indicated.
- `New-InboxRule`: When used to exfiltrate sensitive information, hide malicious activities, or manipulating email flow to suppress alerts or maintain persistence in compromised accounts.
- `Set-InboxRule`: When used to exfiltrate sensitive information, hide malicious activities, or manipulating email flow to suppress alerts or maintain persistence in compromised accounts.
**Less Commonly Used by Attackers:**
- `Set-Mailbox`: Attackers may use this operation to exfiltrate sensitive information, disable security features, modify permissions like 'FullAccess' or 'SendAs', and adjust quota limits to facilitate data exfiltration and avoid detection. Note that this operation can also be legitimately triggered when mailboxes are shared.
- `New-TransportRule` or `Set-TransportRule`: Attackers may create transport rules to intercept or redirect emails across the organization, particularly in multi-user compromises. It's important to note that these rules are also used by Exchange administrators to enforce compliance policies, enhance security, manage email flow, apply organizational communication standards, and ensure the proper handling of sensitive or important information.
**Rarely Used by Attackers:**
- `Add-MailboxFolderPermission`: When `Reviewer` permissions are indicated.
- `New-ManagementRoleAssignment`: May be exploited to assign elevated roles to themselves or the attacker’s tools.


#### Mailbox Keywords That May Indicate a Potential Compromise
- `.bat`, `.exe`, `.iso`, `.ps1`, `.rar`, `.scr`, `.vbs`, `.zip`, `Account`, `ACH`, `Action Required`, `Admin`, `Agreement`, `alert`, `Attachment`, `Attorney`, `Audit`, `Bank`, `Billing`, `CEO`, `CFO`, `Clinical`, `Compliance`, `Confidential`, `Contract`, `Credentials`, `daemon`, `did you`, `Doc`, `License`, `Employee`, `File`, `Hack`, `Helpdesk`, `HIPAA`, `HR`, `Identification`, `Information`, `Internal`, `Invoice`, `IT`, `Key`, `Legal`, `Litigation`, `Locked`, `Manager`, `Medical`, `Passport`, `Password`, `Patient`, `Payment`, `Payment Confirmation`, `Payroll`, `PDF`, `Phish`, `PIN`, `Proposal`, `Reset`, `Restricted`, `Resume`, `RSS`, `Salary`, `Scam`, `Secret`, `Secure`, `Security`, `SSN`, `suspicious`, `Tax`, `Token`, `Transaction`, `Unusual`, `Urgent`, `Verify`, `Wire`

### Task
You are tasked with analyzing the provided mailbox rule output for potential compromise. Focus on:
1. **Mailbox operations and actions configured** and consider the type of behavior associated with threat actors.
2. **Keywords or patterns** that may represent Indicators of Compromise (IoCs) based on current or evolving threats.

**Deliverables:**
1. **List mailbox rules** for each user, sorted by the `TimeGenerated` field and grouped by the count of mailbox rules. Use a horizontal bar (`---`) between each user and indent each new rule to help readability.
2. **Assess each mailbox rule** to determine if its operations and actions likely indicate compromise.
3. **Provide a risk confidence score** for each action using the following levels: `Low`, `Medium`, `High`, `Critical`.
4. **Explain each confidence score**, citing specific keywords, patterns, or behaviors observed in the data.

### Format For Each User
- **User ID:** [User email address, denoted as UserId]
  - **Rule Number:** [Number of rules denoted as 1 of 1, 1 of 2, etc.]
    - **Date and Time:** [Timestamp from "TimeGenerated" field]
    - **Risk Confidence Level:** [Low/Medium/High/Critical]
    - **Mailbox Rule Summary:** [Summarize the actions being taken within the "Parameters_reformatted" field]
    - **Analysis Reasoning:** [Summary of the entire mailbox rule, including identified patterns, whether the mailbox operations are commonly, less commonly, or rarely used by attackers, and any matched keywords, or anomalous behaviors fields that support the "Risk Confidence Level"]
    - **Client IP:** [IP address, denoted as "ClientIP_reformatted"]
