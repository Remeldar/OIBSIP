# Task 2: Basic Firewall Configuration with UFW

## What is a firewall?
A firewall filters network traffic using rules. It decides which
connections may enter or leave a system, which reduces the attack surface.

## Rules and why I chose them
Default: deny all incoming, allow all outgoing (least privilege).
- allow ssh (22): keeps remote administration working.
- deny http (80): blocks plain-text web traffic that is not needed.
- allow https (443): permits encrypted web traffic.
- deny 23/tcp: blocks Telnet, which sends passwords in plain text.
- deny from 203.0.113.0/24: blocks an untrusted IP range.

## Testing
From Metasploitable2 I ran nc -vz -w 5 against Kali.
Port 22 (allowed) connected. Port 80 (denied) timed out.
After ufw disable, port 80 was open; after ufw enable it was blocked again.

## Script
ufw_configuration.sh applies all rules in order:
chmod +x ufw_configuration.sh
sudo ./ufw_configuration.sh

## Screenshots
See the screenshots folder.
