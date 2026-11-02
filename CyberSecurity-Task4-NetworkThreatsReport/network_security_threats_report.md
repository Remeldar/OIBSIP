# Common Network Security Threats

## Introduction

Modern organisations depend on networks for nearly everything they do, from
email and file sharing to banking, healthcare systems, and critical
infrastructure. This dependence makes networks a prime target for attackers,
since a successful attack can disrupt business operations, steal sensitive
data, or cause direct financial loss. Threats such as DDoS attacks,
man-in-the-middle interception, IP spoofing, and DNS poisoning are not
theoretical; they have taken down major websites, stolen tens of millions of
dollars, and exposed the personal data of hundreds of millions of people.
Understanding how these attacks work, and what mitigates them, is a basic
requirement for anyone responsible for keeping a network secure.

## 1. DoS/DDoS Attacks

### How it works
A Denial-of-Service (DoS) attack overwhelms a target server, service, or
network with traffic or requests until it can no longer respond to
legitimate users. A Distributed Denial-of-Service (DDoS) attack does the
same thing but from many sources at once, usually a "botnet" of compromised
devices controlled by the attacker. Because the traffic comes from
thousands of different IP addresses, it is much harder to block than a
single-source attack.

### Real-world example
In October 2016, the Mirai botnet, built from hundreds of thousands of
compromised IoT devices such as home routers and security cameras, was used
to flood Dyn, a major DNS provider, with traffic peaking at over 1 Tbps.
Because many popular sites relied on Dyn for DNS resolution, the attack
knocked Twitter, Netflix, Reddit, GitHub, PayPal, and Airbnb offline for
users across the US and Europe for several hours.

### Impact
- Service outages lasting from minutes to hours, with direct revenue loss
- Reputational damage and loss of customer trust
- Knock-on effects for any third party that depends on the targeted service
- Can be used as a distraction while a separate attack takes place

### Mitigation strategies
1. Use a DDoS protection/scrubbing service (e.g. Cloudflare, Akamai) that
   absorbs and filters malicious traffic before it reaches the origin server.
2. Deploy redundant infrastructure, such as multiple DNS providers and
   geographically distributed servers, so no single point of failure exists.
3. Apply rate limiting and traffic filtering at the network edge to drop
   abnormal traffic spikes before they reach application servers.

## 2. Man-in-the-Middle (MITM) Attacks

### How it works
In a MITM attack, an attacker secretly positions themselves between two
parties who believe they are communicating directly with each other. The
attacker can passively eavesdrop on the traffic or actively alter it, for
example by stealing login credentials or injecting malicious content. Common
techniques include ARP spoofing on a local network, rogue Wi-Fi hotspots,
and abusing weak or forged TLS/SSL certificates.

### Real-world example
In 2015, Lenovo was found to be pre-installing adware called Superfish on
consumer laptops. Superfish installed its own root certificate in the
browser and acted as a MITM proxy on all HTTPS traffic in order to inject
ads, breaking the trust model of encrypted connections for every affected
user. Once security researchers extracted Superfish's private key, any
attacker on the same network as an affected laptop could intercept that
user's "secure" banking and email traffic.

### Impact
- Theft of login credentials, session tokens, and financial information
- Loss of confidentiality for any data sent over the compromised connection
- Erosion of trust in HTTPS/TLS if certificate authorities are compromised
- Potential for follow-on attacks such as identity theft or fraud

### Mitigation strategies
1. Enforce HTTPS everywhere and use HSTS so browsers refuse to downgrade
   to an unencrypted connection.
2. Use certificate pinning or verify certificate authorities carefully,
   and avoid installing software that adds unknown root certificates.
3. Avoid untrusted public Wi-Fi for sensitive activity, or use a VPN to
   encrypt traffic end-to-end when such networks must be used.

## 3. IP Spoofing

### How it works
IP spoofing is the practice of forging the source IP address in a packet's
header so that it appears to come from a trusted or different machine. This
is commonly used to hide the attacker's real origin, to bypass IP-based
access controls, or to power reflection/amplification DDoS attacks, where
the attacker spoofs the victim's IP so that responses from many servers are
all sent back to the victim at once.

### Real-world example
IP spoofing is the technique behind most large-scale DNS amplification
DDoS attacks, including the 2013 attack on Spamhaus, where attackers sent
DNS queries to open resolvers with the source address spoofed as
Spamhaus's IP. Each small request triggered a much larger DNS response,
and because the source was forged, all of that amplified traffic was sent
directly at Spamhaus, generating roughly 300 Gbps of attack traffic.

### Impact
- Enables powerful amplification DDoS attacks against a spoofed victim
- Can bypass simple firewall rules that trust traffic from specific IPs
- Makes attribution and incident response far more difficult
- Can be used to hijack sessions if combined with sequence-number guessing

### Mitigation strategies
1. Implement ingress and egress filtering (BCP 38) at the network edge so
   routers drop packets with source addresses that could not legitimately
   originate from that network.
2. Disable or restrict open DNS resolvers and other services that can be
   abused for reflection/amplification attacks.
3. Use authentication methods that do not rely on IP address alone, such as
   mutual TLS or cryptographic tokens, for access control.

## 4. DNS Poisoning/Spoofing

### How it works
DNS poisoning (also called DNS cache poisoning or spoofing) involves
inserting fake DNS records into a resolver's cache, so that a domain name
resolves to an attacker-controlled IP address instead of the real one.
Victims who type a legitimate address, such as their bank's website, are
silently redirected to a fake site that looks identical, where their
credentials can be captured.

### Real-world example
In 2018, attackers used a DNS spoofing attack against Amazon Web Services'
Route 53 DNS infrastructure to redirect visitors of the cryptocurrency
wallet service MyEtherWallet to a fake, malicious copy of the site. Victims
who entered their wallet credentials on the fake site had their funds
stolen, resulting in a loss of roughly $17 million worth of Ethereum.

### Impact
- Credential theft and financial fraud via convincing fake websites
- Malware distribution if users are redirected to pages serving exploits
- Can be used for large-scale censorship, as seen with national firewalls
- Difficult for an end user to detect, since the browser address bar still
  shows the correct domain name

### Mitigation strategies
1. Deploy DNSSEC, which cryptographically signs DNS records so resolvers
   can verify that a response has not been tampered with.
2. Use randomised query IDs and source ports for DNS requests, making it
   much harder for an attacker to guess and forge a matching response.
3. Restrict DNS caching and recursion to trusted resolvers, and keep DNS
   server software patched against known cache-poisoning techniques.

## Comparison Table

| Threat | Attack Vector | Who is at Risk | Difficulty to Execute | Ease of Mitigation |
|---|---|---|---|---|
| DoS/DDoS | Flooding a target with traffic from one or many sources | Any internet-facing service or organisation | Low to Medium (botnets can be rented) | Medium (requires scrubbing services/redundancy) |
| MITM | Intercepting traffic between two parties on a network or via a forged certificate | Users on untrusted networks, organisations with weak TLS practices | Medium (needs network position or compromised trust) | Medium (HTTPS, HSTS, VPNs) |
| IP Spoofing | Forging the source IP address of packets | Networks without edge filtering, services vulnerable to amplification | Low to Medium | Medium (ingress/egress filtering) |
| DNS Poisoning | Injecting false records into a DNS resolver's cache | Any user or organisation relying on unprotected DNS | Medium to High (modern resolvers are harder to poison) | Medium to High (DNSSEC is not yet universal) |

## Conclusion

Three key takeaways for a network administrator:

1. **No single defence is enough.** DDoS protection, encryption, filtering,
   and DNSSEC each address a different threat, so layered defences across
   the network are necessary rather than relying on one control.
2. **Trust nothing by source address or appearance alone.** IP addresses,
   certificates, and DNS responses can all be forged, so verification
   (cryptographic where possible) must replace simple assumptions of trust.
3. **Redundancy and monitoring reduce impact, not just risk.** Attacks such
   as the Dyn DDoS incident show that even well-resourced organisations get
   hit; what limits the damage is having redundant infrastructure and the
   ability to detect and respond quickly.

## References

1. CISA — Understanding Denial-of-Service Attacks: https://www.cisa.gov/news-events/news/understanding-denial-service-attacks
2. NIST Special Publication 800-61 (Computer Security Incident Handling Guide): https://csrc.nist.gov/pubs/sp/800/61/r2/final
3. MITRE ATT&CK — Network Denial of Service (T1498): https://attack.mitre.org/techniques/T1498/
4. Cloudflare Learning Center — What is DNS Spoofing/Poisoning: https://www.cloudflare.com/learning/dns/dns-cache-poisoning/
5. Cloudflare Learning Center — Famous DDoS Attacks: https://www.cloudflare.com/learning/ddos/famous-ddos-attacks/
