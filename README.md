
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Firewall Rules Conflicts Incident

Firewall Rules Conflicts Incident refers to a situation where there is a conflict between different rules in the firewall configuration that is causing network traffic to be blocked or allowed unexpectedly. This can lead to disruptions in network connectivity, security breaches, and other issues that can negatively affect the performance of the system. Resolving this incident requires careful analysis of the firewall configuration, identification of the conflicting rules, and implementing necessary changes to restore network connectivity and security.

### Parameters

```shell
export PORT_NUMBER="PLACEHOLDER"
export IP_ADDRESS="PLACEHOLDER"
export PROTOCOL="PLACEHOLDER"
export PATH_TO_FIREWALL_CONFIG="PLACEHOLDER"
```

## Debug

### Check currently applied firewall rules

```shell
sudo iptables -L
```

### Check active network connections and their states

```shell
sudo netstat -natp
```

### Check if the firewall service is running

```shell
sudo systemctl status firewalld
```

### Check for conflicts in the firewall rules

```shell
sudo iptables -nvL | grep DROP
```

### Check for conflicts in the firewall rules with a specific port

```shell
sudo iptables -nvL | grep DROP | grep ${PORT_NUMBER}
```

### Check for conflicts in the firewall rules with a specific IP address

```shell
sudo iptables -nvL | grep DROP | grep ${IP_ADDRESS}
```

### Check for conflicts in the firewall rules with a specific protocol

```shell
sudo iptables -nvL | grep DROP | grep ${PROTOCOL}
```

### Check firewall logs for any errors or conflicts

```shell
sudo tail /var/log/messages
```

## Repair

### Review firewall rules and remove any conflicting or redundant rules.

```shell
#!/bin/bash

# Set the path to the firewall configuration file
FIREWALL_CONF=${PATH_TO_FIREWALL_CONFIG}

# Create a backup of the current firewall configuration
cp $FIREWALL_CONF $FIREWALL_CONF.bak

# Review the firewall rules and remove any conflicting or redundant rules
# In this example, we'll remove any rules that allow traffic from port 80
sed -i '/allow.*port 80/d' $FIREWALL_CONF

# Reload the firewall configuration
iptables-restore < $FIREWALL_CONF

# Print a message indicating the remediation is complete
echo "Firewall rules have been reviewed and conflicting or redundant rules have been removed."
```