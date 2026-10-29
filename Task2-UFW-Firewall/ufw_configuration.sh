#!/bin/bash
ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw deny http
ufw allow https
ufw deny 23/tcp
ufw deny from 203.0.113.0/24
ufw --force enable
ufw status verbose
