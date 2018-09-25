$DockerGetStartedSwitchName = "DockerGetStartedSwitch"

Invoke-Expression `
    -Command "$PSSCRIPTROOT/removeTempHypervSwitch.ps1"

Import-Module Hyper-V

$EthernetAdapter = Get-NetAdapter `
    -Name "ethernet"

New-VMSwitch `
    -Name $DockerGetStartedSwitchName `
    -NetAdapterName $EthernetAdapter.Name `
    -AllowManagementOS $true `
    -Notes "Docker ""GetStarted"" Test Switch"