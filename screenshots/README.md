# Screenshot checklist

Save each file with the exact name below. Crop out the tenant domain and full email addresses (keep `employee.demo@` / `outsider.demo@` prefixes if you like). Blur test card numbers and SSNs even though they're synthetic.

| File | Where to capture it |
|---|---|
| `phase-1/01-audit-search.png` | Purview → Audit → Search → Activities "Accessed file" |
| `phase-1/02-labels.png` | Purview → Information Protection → Sensitivity labels (showing the Confidential \ Client Data hierarchy) |
| `phase-1/03-baseline-outsider-denied.png` | InPrivate as outsider → site URL → "You need access to this site" |
| `phase-1/04-content-explorer-sits.png` | Purview → Information Protection → Explorers → Content explorer → SSN / Credit Card |
| `phase-1/05-dspm-before-assessment.png` | Purview → DSPM for AI → Data risk assessments → "– Before" |
| `phase-2/01-overshare-grant.png` | Client Billing folder → Manage access, showing Everyone except external users |
| `phase-2/02-outsider-search-hit.png` | InPrivate (Edge) as outsider → SharePoint search "billing" |
| `phase-2/03-audit-who-shared.png` | Purview → Audit → "Shared file, folder, or site", user employee.demo@ |
| `phase-2/04-autolabel-policy.png` | Purview → Information Protection → Auto-labeling policies |
| `phase-2/05-outsider-denied-with-link.png` | Outsider opening the org-wide link → encryption denial |
| `phase-2/06-dlp-policy-tip.png` | A labeled file showing the DLP policy tip |
| `phase-2/07-dspm-before-after.png` | DSPM for AI → the "– Before" and "– After" assessments side by side |
| `phase-3/01-ca-policy-list.png` | Entra → Conditional Access → Policies |
| `phase-3/02-signin-log-ca-applied.png` | Entra → Sign-in logs → an entry → Conditional Access tab |
| `phase-3/03-pim-activation.png` | Entra → PIM → My roles → Activate Global Administrator |
| `phase-3/04-copilot-agent-employee.png` | Copilot Studio test pane (or Teams) signed in as employee |
| `phase-3/05-copilot-agent-outsider.png` | Same question signed in as outsider |
