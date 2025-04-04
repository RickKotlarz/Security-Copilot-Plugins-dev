## Module 1 - Basics of Prompt Engineering - Security Copilot

![Security Copilot Logo](../.././Images/ic_fluent_copilot_64_64%402x.png)

Authors: Rick Kotlarz<br>
Updated: 2025-April-3

#### ⌛ Estimated time to complete this lab: 15 minutes
#### 🎓 Level: 100 (Beginner)

The following module demonstrate effective prompt engineering for those just starting out with Security Copilot.

1. [How Security Copilot works](#initial-prompt)
2. [Prompting basics](#prompting-basics)
3. [Bad prompting](#bad-prompting)
4. [Good prompting](#good-prompting)


### How Security Copilot works

Regardless of whether your in the embedded or standalone experiences, Security Copilot prompts are evaluated by what's called the Orchestrator. The  Orchestrator's primary function is to interpret your prompt, check enabled plugins, then map the values of your prompt to the appropriate fields within one or more skills. As you can imagine, not including enough information in your prompts often leads to poor responses or no response at all. 

Prompts within an embedded experience pre-select a given plugin for that embedded experience. If you're within a Purview DLP experience, asking questions about Intune or Defender will often fail to produce results or simply give incomplete responses.

However within the standalone experience, prompting supports all enabled plugins and leverages the existing security context of your current role. If you're a user with access to data within a given plugin, then associated plugins and skills within those plugins will allow you to recieve respones for those skills. If your existing security context doesn't permit you access, then prompts that offer access to that information will not be processed.

### Prompting basics

While the order of these isn't important, including them in your prompts definitely improves the outcome.

![Image](./images/001_module1_basic_elements.png)

### Bad prompting

Bad prompts contains vague and highly subjective elements related to **Goal, Context, Source, or Expectation**

**Bad examples prompts:**

| Bad prompt examples | Reasoning why they're bad |
|--------|--------|
| Show me important alerts. | The word "important" is highly subjective and results will vary greatly. |
|  How’s my security posture? | Security posture could relate to a multitude of resources in the Security and Compliance stack. Additionally there is no plugin or skill that provides a total review of your security posture so asking this would result in a response based on missing information.|
| How is my security posture from Defender looking today? Show results in a table. | Same as above |
| What's the compliance status of this entity? | Compliance could relate to something in Intune, Purview, Entra, or otherwise. | 
| Tell me the MFA status for device ASH-U2746 | Devices don't have a MFA status, so asking about this instead of the MFA status of the user who's currently or last logged in will fail to render an appropriate response. |
| What's the MFA status for that user | Not including the actual named entity in a prompt will almost always lead to an error down the line. It's better to use a UPN, FQDN, Resource Object ID or another identifier that only exists as a single unique identifier within your organization. |

### Good prompting

Good prompts contains specefic elements related to **Goal, Context, Source, or Expectation**

**Good example prompts:**
| Good prompt examples |
|--------|
| Using the Defender XDR plugin, provide an SOC manager summary of all Defender incidents over the last 7 days |
| Using NL2KQL for Defender, show me a list of alerts with 'phish' in the title for the last 30 days |
| Using Intune, provide a table showing the last 3 devices that were enrolled and their Operating System |
| Using Entra, what is the MFA enrollment status for user: john.smith@contso.com |
| Using Purview show the last 30 DLP alerts. For each user listed, provide a count of how many times they were included. |
| Using Purview, provide a list of all users that triggered DLP alerts over the last 30 days. For each user, provide their UPN and a count of how many alerts they were associated with. |
