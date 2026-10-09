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

- `screenshots/phase-1/01-audit-search.png`
- `screenshots/phase-1/02-labels.png`
- `screenshots/phase-1/03-baseline-outsider-denied.png`
- `screenshots/phase-1/04-content-explorer-sits.png`
- `screenshots/phase-1/05-dspm-before-assessment.png`
