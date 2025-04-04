## Module 1 - Basics of Prompt Engineering - Security Copilot

![Security Copilot Logo](../.././Images/ic_fluent_copilot_64_64%402x.png)

Authors: Rick Kotlarz<br>
Updated: 2025-April-3

#### ⌛ Estimated time to complete this lab: 15 minutes
#### 🎓 Level: 100 (Beginner)

The following module demonstrate effective prompt engineering for those just starting out with Security Copilot.

1. [How](#initial-prompt)
2. [test](#test)
3. [test](#test)


### How Security Copilot works

Regardless of whether your in the embedded or standalone experiences, Security Copilot prompts are evaluated by what's called the Orchestrator. The  Orchestrator's primary function is to interpret your prompt, check enabled plugins, then map the values of your prompt to the appropriate fields within one or more skills. As you can imagine, not including enough information in your prompts often leads to poor responses or no response at all. 

Prompts within an embedded experience pre-select a given plugin for that embedded experience. If you're within a Purview DLP experience, asking questions about Intune or Defender will often fail to produce results or simply give incomplete responses.

However within the standalone experience, prompting supports all enabled plugins and leverages the existing security context of your current role. If you're a user with access to data within a given plugin, then associated plugins and skills within those plugins will allow you to recieve respones for those skills. If your existing security context doesn't permit you access, then prompts that offer access to that information will not be processed.

### Prompting basics

Basic elements of an effective prompt within Security Copilot include:
1. Goal - specific, security-related information that you need
2. Context - why you need this information or how you plan to use it
3. Source - known information, data sources, plugins or skills that Security Copilot should use
4. Expectations - format or target audience you want the response tailored to (if relevant)

While the order of these isn't important, including them is.

Example of a good prompt:
Provide a summary of incident 54321 for a report that I can submit to my manager. Look in Defender incidents. Compile the information in a list, with a short summary at the end.

![Image](./images/001_prompt_no_Markdown.png)

### Bad prompting

Bad prompts contains vague and highly subjective elements related to **Goal, Context, Source, or Expectation**

**Bad examples prompts:**
 - Prompt: Show me important alerts.
  - Result: Important is highly subjective and results will vary greatly
 - Prompt: How’s my security posture?
  - Result: Security posture could relate to a multitude of resources and there is no skill that provides a total review of your security posture.
 - How is my security posture from Defender looking today? Show results in a table.
 - What's the compliance status of this entity?
 - Tell me the MFA status for

### Good prompting
Contains specific [Goal + Context + Source + Expectation] elements
Good example prompts
Using the Defender XDR plugin, provide an SOC manager summary of all Defender incidents over the last 7 days. 

