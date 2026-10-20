# Phase 3 — Govern

## Break-glass first

Before any Conditional Access policy:
- A cloud-only break-glass account with permanent Global Admin, a long random password stored offline, and its own phishing-resistant MFA method (not my daily phone).
- A security group `CA-Exclude-BreakGlass`, excluded from **every** policy. This is what prevents locking the tenant out.
- Security defaults disabled (they're mutually exclusive with Conditional Access).

## Conditional Access

Every policy was created in **report-only**, checked in the sign-in logs' report-only tab, then turned on.

| Policy | Users | Target | Control |
|---|---|---|---|
| CA01 Require MFA for admins | Admin directory roles | All resources | Require MFA |
| CA02 Require MFA for admin portals | All users | Microsoft Admin Portals + Azure Service Management API | Require MFA |
| CA03 Block legacy authentication | All users | All resources (Exchange ActiveSync, other clients) | Block |
| CA04 Require MFA for all users | All users | All resources | Require MFA |
| CA06 Block sign-ins outside allowed countries | All users (travel exception group excluded) | All resources; named location United States | Block |
| CA07 Block high sign-in risk | All users | All resources; sign-in risk High | Block |
| CA08 High user risk → secure password change | All users | All resources; user risk High | MFA + password change |

All exclude the break-glass group. CA05 (compliant device for client files) is held until a managed endpoint exists.

Notes from rollout:
- The GitHub Actions OIDC identity that deploys ClarityOS is a workload identity, so user Conditional Access policies don't affect it.
- The Azure subscription owner is a guest in this tenant and is caught by CA02; I confirmed its MFA worked before turning CA02 on.

## Privileged Identity Management

| Role | Setting |
|---|---|
| **Global Administrator** | `admin@` is **eligible**, not active. Activation: max 2 hours, MFA, justification required. Break-glass stays permanently active, so there is never zero active Global Admins. |
| Other admin roles held by `admin@` | Eligible, same activation rules |
| **Azure resources** | Eligible Owner/Contributor on the Clarity resource groups instead of standing access **[VERIFY: done in portal or Terraform; the Key Vault Secrets Officer grant is Terraform-managed, so moving it must be a code change]** |

Demo: as `admin@`, no Global Admin → activate in PIM with MFA and justification → Global Admin for 2 hours → the activation in the PIM audit trail.

## Copilot Studio agent that respects permissions

**[VERIFY: fill in from the built agent: name, knowledge source, authentication setting, and the exact test prompts]**

- An agent in Copilot Studio grounded on the `Clarity Client Files` site, with **Entra ID authentication** so it answers as the signed-in user.
- Test: the same question ("what's the billing contact for <client>?") as the employee returns an answer; as the outsider, the agent finds nothing, because the files are labeled and permissioned.
- Power Platform DLP policy restricting which connectors the agent's environment can use **[VERIFY]**.

## Evidence

- Conditional Access Policies <img width="1597" height="765" alt="image" src="https://github.com/user-attachments/assets/0de36465-ff3c-49a3-820c-703b5fc879b3" />
- Conditional Access Policy applied <img width="1742" height="476" alt="image" src="https://github.com/user-attachments/assets/0f147fdb-f5ac-4da8-85a7-2764916b5dd7" />
- Activated PIM <img width="1650" height="327" alt="image" src="https://github.com/user-attachments/assets/3170c52e-5093-4455-aa3b-9b59e6d346c9" />
- `screenshots/phase-3/04-copilot-agent-employee.png`
- `screenshots/phase-3/05-copilot-agent-outsider.png`
