Home SOC Web Defense Lab: SafeLine WAF & DVWA

🛡️ Project Overview :
This project documents the deployment of a robust reverse-proxy Web Application Firewall (WAF) architecture to protect a vulnerable web server. Built entirely within a local virtualization environment, the lab demonstrates the practical configuration of SafeLine WAF to intercept, monitor, and block malicious HTTP traffic targeting a Damn Vulnerable Web App (DVWA) instance. 

This project serves as a foundational component for a broader Home Security Operations Center (SOC) lab, paving the way for advanced log analysis and SIEM (e.g., Splunk) integration.

🏗️ Architecture & Network Topology :
The environment simulates a real-world external attack surface and internal defensive perimeter using VMWareWorkstation Pro. 
Attacker Machine: Kali Linux (Bridged Network) 
Web Server / Victim: Ubuntu Server 22.04 LTS running a LAMP Stack (Apache, MySQL, PHP) 
Vulnerable Application: Damn Vulnerable Web App (DVWA) listening on an alternate port (8080) 
Defensive Layer: SafeLine WAF handling reverse proxy routing (Port 443) and SSL termination 
Local DNS Resolution: Configured via `/etc/hosts` and DNS Server for domain-based routing (`dvwa.local`) 


⚔️ Attack & Defense Scenarios :-

1. SQL Injection (SQLi) Prevention:

The Attack: Executed a standard SQL injection payload (`admin' OR '1'='1`) against the DVWA login module from the Kali Linux attacker machine. 
The Defense: SafeLine WAF successfully intercepted the anomalous SQL syntax. 

2. HTTP Flood & DoS Mitigation:

The Attack: Simulated a high-volume Layer 7 Denial of Service (DoS) attack targeting the web server resources.
The Defense: Configured SafeLine WAF's HTTP Flood defense mechanisms, setting custom thresholds (requests per second) and ban durations to automatically throttle and drop excessive traffic.

3. Custom Access Controls (IP Deny Rules)
   
The Defense: Implemented custom access control policies to outright block specific malicious actors. A custom deny rule was created specifically to drop all traffic originating from the Kali Linux IP address.
SOC Analysis: Verified the rule execution by attempting standard `curl` requests from the attacker machine, resulting in immediate blocks.

🔧 Skills Demonstrated :-

Infrastructure as Code & Virtualization: VirtualBox networking, bridged adapters, and headless server management.
Linux System Administration: LAMP stack configuration, port binding, file permissions, and BIND DNS zone file creation.
Offensive Security Validation: Practical application of OWASP top 10 vulnerabilities (SQLi) using manual testing methods.
Defensive Security Configuration: WAF deployment, SSL/TLS certificate generation, reverse proxy routing, and traffic threshold tuning.
Log Monitoring: Identifying indicators of compromise (IoCs) within WAF administrative dashboards.

🚀 Future Scope :-

To further mature this environment into a comprehensive monitoring platform, upcoming integrations include:
Forwarding SafeLine WAF and Apache access logs to a centralized Splunk instance for SIEM dashboard creation.
Routing all virtual machine traffic through a pfSense firewall to monitor deeper network-level intrusions.
