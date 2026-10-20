# Phase 1 — Discover

## Licensing and users
- Microsoft 365 E5 for all three users, Entra ID P2 for `admin@`.
- **Usage location set first.** License assignment fails or silently doesn't stick without it.
- Users are added to the site's own Microsoft 365 group. A separate Entra security group doesn't grant site access, and Microsoft 365 groups can't nest other groups (I made that mistake once and deleted the stray group).

## Unified audit
Turned on first, because audit only records from the moment it's on.

Verified with PowerShell rather than the portal, which can show "failed to load data" on a new tenant even when audit is working: [`scripts/verify-audit.ps1`](../scripts/verify-audit.ps1).

## Sensitivity labels

Created in priority order (lowest first) and published to all users as `Clarity Labels – All Users`:

| Label | Protection |
|---|---|
| **Public** | None |
| **Internal** | Footer: `Internal – Clarity Process Group` |
| **Confidential** (parent) | None (a parent with sublabels can't be applied) |
| **Confidential \ Client Data** | **Encryption**: only the `Clarity Client Files` Microsoft 365 group, as Editor (includes "copy and extract content", which Copilot needs to read the file for an authorized user); offline access 7 days. Header `CONFIDENTIAL – CLIENT DATA`. |

Publishing policy: justification required to remove or downgrade a label; no mandatory labeling; no default label.

**Auto-labeling was left off at this stage on purpose.** Labeling before the first scan erases the "before" picture.

## Synthetic data and baseline
- Private team site `Clarity Client Files` with folders `Client Billing`, `Clients Contracts`, `Onboarding Forms`.
- Files uploaded **unlabeled**: a 12-business client roster, a quarterly billing summary, two MSAs and three onboarding forms. Every file carries a "synthetic" notice. Card numbers are processor test numbers (Luhn-valid, so they match the Credit Card sensitive information type); SSNs are valid-format but random.
- Baseline: the employee can open the library; the outsider gets "You need access to this site." Permissions on the site are tight. The files inside are not protected.

## Purview detection
- Content explorer (after adding `admin@` to the Content Explorer List Viewer and Content Viewer role groups, which Global Admin doesn't get by default) shows **U.S. SSN, Credit Card Number, ABA Routing Number and U.S. Bank Account Number** hits on the site, all unlabeled.

## DSPM for AI
- One-click DSPM for AI policies created (detect sensitive info added to AI sites, risky AI usage, capture Copilot interactions).
- A custom **data risk assessment** scoped to the client-files site: `Clarity Client Files – Before`. Later runs are duplicates (`– Overshared`, `– After`) so each keeps its own timestamp.
- **Item-level scan** connected through an Entra app registration with a **federated credential**, so there's no client secret to store or rotate. Worth noting in any review: this app has tenant-wide write to SharePoint so it can remediate, which makes the oversharing tool one of the most privileged identities in the tenant. It's single-tenant and reviewed like an admin.

## Evidence

**[VERIFY: capture these, see [screenshots/README.md](../screenshots/README.md)]**

- Audit search <img width="997" height="664" alt="image" src="https://github.com/user-attachments/assets/e33409be-58b1-4fca-8426-14132b32d935" />
- Purview Sensitivity labels <img width="1353" height="842" alt="image" src="https://github.com/user-attachments/assets/493ad3cd-7a0e-4e0a-9cfd-893afa5ed895" />`
- Outsider denied access <img width="1160" height="669" alt="image" src="https://github.com/user-attachments/assets/0499139d-a5b0-4683-9b1d-8681d679b76a" />
- Content Explorer Sits <img width="1331" height="857" alt="image" src="https://github.com/user-attachments/assets/736eb971-ea20-4ee0-983d-f70833da0cd3" />
- DSPM assessment <img width="1169" height="909" alt="image" src="https://github.com/user-attachments/assets/d7fe583d-ea5e-42e1-a2bd-7e6c63051235" />

