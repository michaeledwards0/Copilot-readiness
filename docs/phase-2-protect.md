# Phase 2 — Protect

## Reproduce the oversharing

The most common Copilot blocker isn't a breach. It's a helpful employee sharing too widely.

1. Recorded the tenant's sharing policy and default link type first; they're part of the story.
2. As **`employee.demo@`**, shared the `Client Billing` folder with **Everyone except external users**, view only. Doing it as the employee means the audit log names who did it.
3. As **`outsider.demo@`**, searched the tenant for "billing" and "routing": the billing summary with card and routing numbers came back. The outsider still got "You need access to this site" on the site URL while reading the folder's files.
4. Audit search for "Shared file, folder, or site" shows `employee.demo@` made the change.
5. The `– Overshared` data risk assessment flags the location.

## Remediate: fast fix, then durable fix

| Step | What |
|---|---|
| Remove the overshare | Org-wide grant removed |
| Label now | `Confidential \ Client Data` applied to the roster and billing files |
| Label automatically | Auto-labeling policy on the site for SSN, Credit Card and ABA Routing → `Client Data`. Ran in simulation first, then turned on. |
| Prove it travels with the file | Re-created an org-wide link to the roster. As the outsider, opening it fails: **denied by encryption, even with the link.** |
| Re-measure | `– After` data risk assessment |

## DLP

All policies were created in simulation mode, reviewed, then turned on.

| Policy | Locations | Rule | Action |
|---|---|---|---|
| **Client data – files & email** | Exchange, SharePoint, OneDrive, Teams | Content contains SSN or Credit Card (high confidence, ≥1) **or** label `Client Data`, shared outside the org | Block, policy tip, alert to admin |
| **Client data – Copilot** | Microsoft 365 Copilot and Copilot Chat | Content has label `Client Data` | Prevent Copilot from processing the content |

**[VERIFY: confirm the Copilot DLP policy is enforceable in this tenant. The E5 trial may not include a Microsoft 365 Copilot license; if Copilot Chat isn't available to the test users, say the policy is configured and describe what it would block, rather than showing it blocking.]**

## Evidence

**[VERIFY: capture these, see [screenshots/README.md](../screenshots/README.md)]**

- `screenshots/phase-2/01-overshare-grant.png`
- `screenshots/phase-2/02-outsider-search-hit.png` — blur the test numbers anyway
- `screenshots/phase-2/03-audit-who-shared.png`
- `screenshots/phase-2/04-autolabel-policy.png`
- `screenshots/phase-2/05-outsider-denied-with-link.png`
- `screenshots/phase-2/06-dlp-policy-tip.png`
- `screenshots/phase-2/07-dspm-before-after.png`
