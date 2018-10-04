param (
    [string]$vmName,
    [string]$vmSwitchName,
    [bool]$isMaster
)

Write-Host "

234324 32r ffds gfesgfds gfdsg fds g
fdsg fds
gfds     CENAZ
g
fds gfd gfds gfdsg fds g


"

if ($isMaster -eq $true) {
    Write-Host "
    
    O boss a ligar
    
    "
    docker-machine `
        --native-ssh `
        create `
            -d hyperv `
            --hyperv-virtual-switch $vmSwitchName `
            --swarm-master `
            "$vmName"
} else {
    Write-Host "
    
    Os kids a ligar
    
    "
    docker-machine `
        --native-ssh `
        create `
            -d hyperv `
            --hyperv-virtual-switch $vmSwitchName `
            "$vmName"
}