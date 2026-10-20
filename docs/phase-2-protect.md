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

- Overshare Grant <img width="1352" height="931" alt="image" src="https://github.com/user-attachments/assets/0419292e-1db4-4d60-a178-8883922bb2a3" />
- `screenshots/phase-2/02-outsider-search-hit.png` — blur the test numbers anyway
- Who shared it? Audit <img width="1789" height="874" alt="image" src="https://github.com/user-attachments/assets/a96f085a-da83-4399-ac5b-6bb3572f7763" />
- Auto label policy <img width="1673" height="816" alt="image" src="https://github.com/user-attachments/assets/a44fb82f-c504-4fc2-afa5-f204f5b2b123" />
- DSPM before-after assessment <img width="1682" height="827" alt="image" src="https://github.com/user-attachments/assets/254d9938-7a01-4884-a7cb-5ba0789b10b3" />

