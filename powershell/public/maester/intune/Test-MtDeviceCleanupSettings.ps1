﻿<#
.SYNOPSIS
    Ensure device clean-up rule is configured

.DESCRIPTION
    The device clean-up rule should be configured

.EXAMPLE
    Test-MtManagedDeviceCleanupSettings

    Returns true if the device clean-up rule is configured

.LINK
    https://maester.dev/docs/commands/Test-MtManagedDeviceCleanupSettings
#>
function Test-MtManagedDeviceCleanupSettings {
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if ((Get-MtLicenseInformation EntraID) -eq "Free") {
        Add-MtTestResultDetail -SkippedBecause NotLicensedEntraIDP1
        return $null
    }

    $scopes = (Get-MgContext).Scopes
    $permissionMissing = "DeviceManagementManagedDevices.Read.All" -notin $scopes
    if($permissionMissing){
        Add-MtTestResultDetail -SkippedBecause Custom -SkippedCustomReason "Missing Scope 'DeviceManagementManagedDevices.Read.All'"
        return $null
    }

    $return = $true
    try {
        $deviceCleanupSettings = Invoke-MtGraphRequest -RelativeUri "deviceManagement/managedDeviceCleanupSettings" -ApiVersion beta
        if ((-not $deviceCleanupSettings.deviceInactivityBeforeRetirementInDays) -or ($deviceCleanupSettings.deviceInactivityBeforeRetirementInDays -eq 0)) {
            $testResultMarkdown = "Your intune device clean-up rule is not configured."
            $return = $false
        } else {
            $testResultMarkdown = "Well done. Your intune device clean-up rule is configured to retire inactive devices after $($deviceCleanupSettings.deviceInactivityBeforeRetirementInDays) days."
        }
        Add-MtTestResultDetail -Result $testResultMarkdown
    } catch {
        $return = $false
        Write-Error $_.Exception.Message
    }
    return $return
}