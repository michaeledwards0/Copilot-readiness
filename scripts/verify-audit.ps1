# Verify Microsoft Purview unified audit is on (more reliable than the portal on a new tenant).
# Usage: .\verify-audit.ps1 -AdminUpn admin@<tenant>.onmicrosoft.com
param(
    [Parameter(Mandatory = $true)][string]$AdminUpn
)

if (-not (Get-Module -ListAvailable ExchangeOnlineManagement)) {
    Install-Module ExchangeOnlineManagement -Scope CurrentUser
}

# -DisableWAM: without it the sign-in window can open behind the terminal and look hung.
Connect-ExchangeOnline -UserPrincipalName $AdminUpn -DisableWAM

Get-OrganizationConfig | Format-List IsDehydrated                        # want False
$cfg = Get-AdminAuditLogConfig
$cfg | Format-List UnifiedAuditLogIngestionEnabled                       # want True

if (-not $cfg.UnifiedAuditLogIngestionEnabled) {
    Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true
    Write-Host "Unified audit was off; turned on. Allow up to 60 minutes before searching."
}

Disconnect-ExchangeOnline -Confirm:$false
