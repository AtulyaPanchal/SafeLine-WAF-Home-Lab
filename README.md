# SafeLine WAF Home Lab

A hands-on cybersecurity home lab that deploys **DVWA (Damn Vulnerable Web App)** behind **SafeLine WAF**, then simulates real-world attacks (SQL injection, XSS, HTTP flood) from Kali Linux to observe detection and blocking in real time.

Built on **VMware Workstation Pro** with an **Ubuntu Server 22.04 LTS** target and a **Kali Linux** attacker VM.

## Architecture

```
[Kali Linux Attacker]
        |
        | HTTP/HTTPS requests (port 443)
        v
[SafeLine WAF] <-- Nginx reverse proxy, port 9443 management UI
        |
        | Proxied traffic (port 8080)
        v
[Ubuntu Server -- DVWA] <-- Apache on port 8080, MySQL backend
```

## Stack

| Component | Choice |
|---|---|
| Virtualization | VMware Workstation Pro |
| Target OS | Ubuntu Server 22.04 LTS |
| Attack Machine | Kali Linux (latest) |
| WAF | SafeLine WAF (Community / Pro) |
| Vulnerable App | DVWA |
| Difficulty | Beginner – Intermediate |

## Repository Structure

```
.
├── README.md
├── docs/
│   └── SafeLine_WAF_Homelab_Guide.pdf     # full step-by-step build guide
├── configs/
│   ├── apache-ports.conf                  # Apache listen-port change (80 -> 8080)
│   ├── dvwa-config.inc.php                # DVWA DB config template
│   └── safeline-site-config.md            # SafeLine "Add Site" settings reference
└── scripts/
    ├── 01-ubuntu-lamp-setup.sh             # LAMP stack + system prep
    ├── 02-dvwa-install.sh                  # Clone & configure DVWA
    ├── 03-ssl-cert-generate.sh             # Self-signed SSL cert for SafeLine
    ├── 04-safeline-install.sh              # SafeLine WAF installer
    └── kali-hosts-setup.sh                 # /etc/hosts entry helper for Kali
```

## Quick Start

1. Read the full guide in `docs/SafeLine_WAF_Homelab_Guide.pdf`.
2. Build the two VMs in VMware Workstation Pro (bridged networking).
3. On the Ubuntu Server VM, run the scripts in order:
   ```
   scripts/01-ubuntu-lamp-setup.sh
   scripts/02-dvwa-install.sh
   scripts/03-ssl-cert-generate.sh
   scripts/04-safeline-install.sh
   ```
4. On the Kali VM, run `scripts/kali-hosts-setup.sh` to set up DNS resolution.
5. Follow Section 7 onward in the guide to onboard DVWA into SafeLine and run the attack demos.

## Disclaimer

This lab is for educational use in an isolated home-lab network only. Do not expose DVWA or these configurations to the public internet.
