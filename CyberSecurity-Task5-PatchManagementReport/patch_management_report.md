# The Importance of Patch Management

## Introduction

Patch management is the process of identifying, acquiring, testing, and
deploying software updates (patches) that fix security vulnerabilities,
bugs, or performance issues in operating systems and applications. It sits
at the centre of the vulnerability lifecycle: a flaw is discovered, it is
disclosed and catalogued, a vendor releases a fix, and organisations must
then apply that fix before an attacker exploits the flaw. The gap between
"patch available" and "patch applied" is one of the largest and most
preventable attack surfaces in cybersecurity, because the vulnerability and
its fix are both publicly known, yet many systems remain exposed for
months or years.

## Why Patches Matter

Vulnerabilities are usually found by security researchers, vendors'
internal teams, or sometimes attackers themselves. Once confirmed, a
vulnerability is typically assigned a CVE (Common Vulnerabilities and
Exposures) identifier through the CVE database (cve.mitre.org), and scored
for severity using the Common Vulnerability Scoring System (CVSS). This
public disclosure is a double-edged sword: it lets defenders know exactly
what to fix, but it also tells attackers exactly what to target, especially
on systems that are slow to patch.

**Real-world example 1: WannaCry / EternalBlue (2017).** In March 2017,
Microsoft released patch MS17-010 for a critical SMBv1 vulnerability
(CVE-2017-0144). A month later, the NSA-developed exploit for this flaw,
EternalBlue, was leaked publicly. In May 2017, despite the patch having
been available for two months, the WannaCry ransomware worm used
EternalBlue to infect more than 200,000 computers across 150 countries in
a matter of hours, including large parts of the UK's National Health
Service, causing an estimated £92 million in NHS losses alone and billions
of dollars in global damage.

**Real-world example 2: Equifax breach (2017).** On March 7, 2017, Apache
disclosed CVE-2017-5638, a critical remote code execution flaw in the
Apache Struts web framework, and released a patch the same day. Equifax
was notified and internally instructed staff to apply the patch, but a
scan intended to find vulnerable systems failed to detect it, and the
patch was never applied to Equifax's public-facing dispute portal.
Attackers exploited the unpatched flaw starting in mid-May 2017, and by
the time Equifax discovered the breach in late July, the personal data of
approximately 147 million people had been exposed.

Both incidents involved publicly known vulnerabilities with patches already
available; the breaches happened not because the flaws were unknown, but
because the patches were not applied in time.

## Consequences of Not Patching

- **Data breaches:** as seen with Equifax, unpatched software is one of the
  most common initial access points attackers use to reach sensitive data.
- **Ransomware attacks:** WannaCry and its successor NotPetya both spread
  through the same unpatched SMB vulnerability, together causing an
  estimated combined economic impact of well over $10 billion.
- **Compliance violations and financial penalties:** Equifax agreed to a
  settlement of up to $700 million with the FTC and other regulators over
  the breach, and organisations subject to frameworks like PCI-DSS or
  HIPAA can face direct fines for failing to patch known vulnerabilities
  within required timeframes.
- **Operational disruption:** the NHS cancelled an estimated 19,000
  appointments and operations during the WannaCry incident, showing that
  unpatched systems can cause real-world harm beyond financial loss.

## Patch Management Lifecycle

1. **Discovery.** Identify all assets on the network (servers, endpoints,
   applications, firmware) and continuously scan them against known
   vulnerability databases (such as the CVE database and vendor advisories)
   to find which systems are missing patches.
2. **Assessment.** Evaluate each missing patch's severity (using CVSS
   scores), the criticality of the affected system, and whether the
   vulnerability is being actively exploited, in order to prioritise which
   patches to apply first.
3. **Testing.** Apply the patch in a non-production/staging environment
   first to confirm it does not break existing functionality or introduce
   new problems, since a poorly tested patch can itself cause an outage.
4. **Deployment.** Roll the patch out to production systems, usually in
   a phased or staged manner (e.g. a small pilot group first, then the
   wider fleet) to limit the impact if something unexpected occurs.
5. **Verification.** Confirm that the patch was successfully applied
   across all intended systems, re-scan to ensure the vulnerability is
   actually closed, and document the change for audit purposes.

## Best Practices: 7-Step Patch Management Checklist

1. Maintain a complete, up-to-date inventory of every asset (hardware,
   OS, and software) on the network, since you cannot patch what you do
   not know exists.
2. Subscribe to vendor security bulletins and monitor the CVE database
   for vulnerabilities affecting your inventory.
3. Score and prioritise patches by CVSS severity and real-world exploit
   activity, not just by release date.
4. Test every patch in a staging environment that mirrors production
   before wide deployment.
5. Deploy critical/actively-exploited patches on an accelerated
   timeline (days, not months), and schedule routine patches on a
   regular, predictable cadence (e.g. "Patch Tuesday" monthly cycles).
6. Automate patch deployment and scanning wherever possible to reduce
   human delay and error.
7. Verify and document every patch cycle, including which systems were
   updated, which were missed and why, and when remediation is planned.

## Challenges and How to Overcome Them

- **Legacy systems:** older systems may no longer receive vendor patches,
  or patching them may break custom software built on top. Overcome this
  by isolating legacy systems on a segmented network, applying
  compensating controls (such as strict firewall rules), and building a
  roadmap to retire or replace them.
- **Downtime concerns:** patching production systems, especially in
  healthcare or manufacturing, can require taking critical services
  offline. Overcome this with phased rollouts, maintenance windows, and
  redundant/failover systems so one node can be patched while others stay
  live.
- **Testing requirements:** thorough testing takes time, which creates
  pressure to skip it under deadline pressure, risking an outage from a
  bad patch. Overcome this by maintaining an automated staging
  environment that mirrors production closely, so testing is fast rather
  than being skipped entirely.
- **Resource and staffing limits:** many organisations, especially
  smaller ones, lack dedicated patch management staff. Overcome this with
  automated patch management tools and managed security service
  providers that handle scanning and deployment on the organisation's
  behalf.

## References

1. NIST Special Publication 800-40 Rev. 4 — Guide to Enterprise Patch Management Planning: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-40r4.pdf
2. CISA — Understanding Patches and Software Updates: https://www.cisa.gov/news-events/news/understanding-patches-and-software-updates
3. CVE Program (MITRE) — Common Vulnerabilities and Exposures Database: https://cve.mitre.org/
4. NVD (National Vulnerability Database) — CVE-2017-5638 (Equifax/Apache Struts):
