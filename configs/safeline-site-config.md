# SafeLine WAF — "https://docs.waf.chaitin.com/en/GetStarted/Deploy" Configuration Reference

Use these values when onboarding DVWA in the SafeLine management UI
(**Site / Applications → Add Site**).

| Setting | Value |
|---|---|
| Domain / Server Name | `www.dvwa.local` (or `dvwa.local`) |
| Listen Port | `443` (remove port 80 if present) |
| Backend (Upstream) URL | `http://<Ubuntu-IP>:8080` |
| SSL Certificate | The self-signed cert generated in `scripts/03-ssl-cert-generate.sh` |
| Protection Mode | `Protection` (blocking mode) |

## Advanced Configuration Notes

### HTTP Flood Defense
- Threshold: 50 requests/second from a single IP → challenge or block
- Penalty duration: 60 seconds

### Authentication Gateway
- Enable "Auth Sign-In" / "Human Verification" on the site config
- Set a username/password separate from DVWA's own credentials

### IP Deny Rule (for testing)
- Match: Source IP = `<Kali IP>`
- Action: Block
- Remember to remove/disable after testing

## Troubleshooting
- **502 Bad Gateway** → DVWA backend unreachable. Verify Apache is on port 8080:
  `curl -I http://localhost:8080/DVWA/`
- **Cannot reach management UI on 9443** → check Docker:
  `sudo systemctl status docker && sudo docker ps`
