# Copilot Readiness — Clarity Process Group

**Getting a Microsoft 365 tenant ready for Copilot: find the oversharing, label and protect the sensitive data, lock down admin access, and prove an agent only sees what its user can.**

Microsoft Purview (sensitivity labels, DLP, DSPM for AI, audit) · Entra ID (Conditional Access, PIM) · SharePoint · Copilot Studio

---

## What this is

Copilot answers from whatever a user can reach. In most tenants that includes files nobody meant to share, so the first Copilot rollout question is "what can everyone already see?"

I ran the full readiness process in **Clarity Process Group's own Microsoft 365 tenant**, with **synthetic client data** (fictional businesses, test card numbers, made-up SSNs). No real client or personal data is in this tenant.

This is the Microsoft 365 half of my AI security work. The Azure half, securing ClarityOS's production AI agents, is in **[securing-clarityos](https://github.com/michaeledwards0/securing-clarityos)**.

## The scenario

| User | Role | Should see client files? |
|---|---|---|
| `admin@` | Administrator, site owner | Yes (via just-in-time admin) |
| `employee.demo@` | Client-files staff, member of the site's Microsoft 365 group | Yes |
| `outsider.demo@` | Same company, not on the client team | **No** |

The `Clarity Client Files` SharePoint site holds a client roster (SSN, date of birth, EIN), a billing summary (card numbers, routing numbers), contracts and onboarding forms.

## Three phases

| Phase | Summary | Doc |
|---|---|---|
| **1. Discover** | Audit on, a four-level label taxonomy published, the "before" baseline, Purview content explorer and **DSPM for AI** showing unprotected sensitive data | [phase-1-discover](docs/phase-1-discover.md) |
| **2. Protect** | Reproduce real oversharing (a staff member shares a folder org-wide), watch the outsider reach SSNs, then remediate: remove the share, label the files, auto-label, and DLP for files, email and Copilot | [phase-2-protect](docs/phase-2-protect.md) |
| **3. Govern** | Break-glass account, Conditional Access policies (report-only first), PIM just-in-time Global Admin, and a Copilot Studio agent that respects the user's permissions | [phase-3-govern](docs/phase-3-govern.md) |

## The result in one line

The outsider went from finding SSNs and card numbers in tenant search to being denied by encryption **even when holding a working link**, and the Copilot Studio agent answers the employee's question but not the outsider's.

## Repo layout

```
docs/          phase write-ups, including the exact label, DLP and Conditional Access settings
scripts/       PowerShell used to verify audit configuration
screenshots/   before/after evidence, one folder per phase
```

## What's next

- Managed endpoint (Entra-joined Windows 11 Enterprise VM) for endpoint DLP and shadow-AI discovery: blocking paste of Client Data into third-party AI sites
- Microsoft 365 data connector into the same Sentinel workspace as ClarityOS, with a rule for sensitive files shared org-wide
- Container labels on the site itself

---

Michael Edwards · Founder & Cloud/AI Security Engineer, Clarity Process Group · [LinkedIn](https://linkedin.com/in/michael-edwards-cloud)
