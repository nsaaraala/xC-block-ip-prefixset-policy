# xC-block-ip-prefixset-policy

# Terraform Code for Managing IP Blocklists with Volterra

This repository contains Terraform code to create and manage IP blocklists for your Volterra environment using prefix sets. The code automates the following:

1. **Reading IP addresses from a text file** (`ips.txt`).
2. **Chunking the IP addresses** into smaller sets (with a maximum of 1024 IPs per chunk).
3. **Creating `volterra_ip_prefix_set` resources** for each chunk of IP addresses.
4. **Creating a `volterra_service_policy`** that includes the prefix sets dynamically in the `deny_list` section.

## Prerequisites

Before you can use this Terraform configuration, you need to have the following:

- **Terraform** installed on your local machine.
- A **Volterra** account with API access and proper authentication credentials.
- The **`ips.txt` file** containing the IP addresses that you want to block. The file should have one IP address per line (e.g., `192.168.1.1`).

## Usage

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/nsaaraala/xC-block-ip-prefixset-policy.git
cd your-repo-name

2. Add the ips.txt File
Ensure that you have an ips.txt file containing the list of IP addresses that you want to block. This file should be in the same directory as your Terraform configuration.

Example ips.txt:

192.168.1.1
192.168.1.2
192.168.1.3
...

3. Initialize the Terraform Working Directory
Run the following command to initialize the Terraform configuration:


terraform init

4. Apply the Terraform Configuration
Run the following command to apply the Terraform configuration:


terraform apply

Terraform will display a plan of the resources it intends to create. Review the plan and type yes to proceed with the creation of the resources.

5. Verify the Resources
Once the Terraform apply is complete, you can log into your Volterra console to verify that:

IP prefix sets are created with the desired chunks of IP addresses.
Service policy has been created and is configured to use the deny_list with the dynamically generated prefix sets.
