# Configuration File Guide

This document provides an overview of how to update the configuration file used in this project. The configuration file is written in YAML and structured into various sections, each represented by a **key**. The Jinja templating engine processes this configuration to generate content for the GitLab Pages site.

## Structure of the Configuration File

Each section in the configuration file consists of multiple keys. Below is an explanation of these keys and how to modify them.

| **Key**       | **Description** |
|--------------|---------------|
| `title` | The section title. This is the main identifier for each section. |
| `description` | A brief description of the section. This remains mostly static and does not require frequent updates. |
| `icon` | Represents an icon associated with the section. This is optional and does not typically need modification. |
| `tags` | A dictionary whose value is a list. It defines responsible teams for completing the section. Use single quotes if the value contains special characters like colons (`:`). |
| `configs` | A dictionary whose value is a list. It contains references to configuration files relevant to the section. These files reside in the `configs` folder inside the respective service directory (`services/<service_name>/configs`). |
| `images` | A dictionary whose value is a list. To add an image, upload it to the `images` folder inside the respective service directory (`services/<service_name>/images`) and then reference its filename here. Image names are case-sensitive, and single quotes are recommended. |
| `tables` | A dictionary whose value is another dictionary, representing tables. Each table consists of a **title** (the key) and a **list of dictionaries**, where each dictionary represents a row. Ensure all column names are consistent across entries, as Jinja dynamically loops over them. |
| `bullets` | A dictionary where each key represents a **bullet title**, and its value is a list of sub-bullets that will be displayed underneath. |

## Guidelines for Updating the Configuration File

- **Modifying Tags:**  
  - Responsible teams should be listed in a YAML list format.
  - Example:
    ```yaml
    tags:
      - "Cloud Security"
      - "Enterprise Data Architecture"
      - "Cyber Security - IAM"
    ```
  - If a value contains special characters (e.g., `Cyber Security: IAM`), wrap it in single quotes (`'Cyber Security: IAM'`).

- **Adding Configuration References:**  
  - Configuration references should match the filenames inside the `configs` folder of the relevant service.
  - Example:
    ```yaml
    configs:
      - example.yml
    ```

- **Adding Images:**  
  - Upload images to `services/<service_name>/images/` before referencing them.
  - Example:
    ```yaml
    images:
      - 'example.png'
    ```
  - Filenames are **case-sensitive**.

- **Creating Tables:**  
  - Define tables with a title as the key.
  - Each table consists of a list of dictionaries, where each dictionary represents a row.
  - Ensure all column names are the same across entries.
  - Example:
    ```yaml
    tables:
      "Example Table":
        - Column A: Example text 1
          Column B: [Example Link 1](https://www.google.com)
        - Column A: Example text 2
          Column B: [Example Link 2](https://www.google.com)
    ```

- **Adding Bullet Points:**  
  - Define bullet points using a key for the main bullet and a list for sub-bullets.
  - Example:
    ```yaml
    bullets:
      "Current Approval Scope":
        - EMR is currently approved for Lab/Dev usage.
      "Target Approval Scope":
        - EMR will be permanently approved for all environments.
    ```

## Best Practices

- **Handling Special Characters:**  
  - Use **single quotes** (`'`) around values containing special characters like colons (`:`).
  - Example:
    ```yaml
    tags:
      - 'Cyber Security: IAM'
    ```

- **Formatting Links:**  
  - Use Markdown format: `[display text](URL)`.
  - Example:
    ```yaml
    tables:
      "Reference Links":
        - Name: [Example Link](https://www.example.com)
    ```

This guide ensures consistency in updating the configuration file and allows Jinja to generate accurate content dynamically.
