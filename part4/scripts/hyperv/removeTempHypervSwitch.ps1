$DockerGetStartedSwitchName = "DockerGetStartedSwitch"

Import-Module Hyper-V

$DockerGetStartedSwitch = Get-VMSwitch  `
    -Name $DockerGetStartedSwitchName

if ($null -ne $DockerGetStartedSwitch) {
    Remove-VMSwitch `
        -Name $DockerGetStartedSwitchName `
        -Force
}