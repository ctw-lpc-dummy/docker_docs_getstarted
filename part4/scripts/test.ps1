# Variable zone

$DockerGetStartedSwitchName = "DockerGetStartedSwitch"
$DockerSwarmNodeNames = @("myvm1", "myvm2")

# Function zone
function createAndStartVm {
    param (
        [String]$vmName,
        [String]$vmSwitchName,
        [bool]$isMaster = $false
    )
    
    Invoke-Expression `
        -Command "$PSSCRIPTROOT/dockerMachine/create.ps1 -vmName ""$vmName"" -vmSwitchName ""$vmSwitchName"" -isMaster $([int]$isMaster)"


    # Using "--native-ssh" I don't think that I need to use regenCerts.ps1
    # Invoke-Expression `
    #     -Command "$PSSCRIPTROOT/dockerMachine/regenCerts.ps1 -vmName ""$vmName"""

    Invoke-Expression `
        -Command "$PSSCRIPTROOT/dockerMachine/start.ps1 -vmName ""$vmName"""
}

function createAndStartVms {
    param (
        [String[]]$vmNames,
        [String]$vmSwitchName
    )

    $count = 0

    foreach ($nodeName in $DockerSwarmNodeNames) {

        if ($count -eq 0) {
            createAndStartVm $nodeName $DockerGetStartedSwitchName $true
        } else {
            createAndStartVm $nodeName $DockerGetStartedSwitchName $false
        }

        $count++

        Write-Host "count -> $count"
    }
}

function deleteVm {
    param (
        [String]$nodeName
    )

    docker-machine rm -f $nodeName
}

function deleteVms {
    param (
        [String[]]$nodeNames
    )

    foreach ($nodeName in $DockerSwarmNodeNames) {
        deleteVm $nodeName
    }
}

# Real Code

# Clean HyperV Ethernet Switch
Invoke-Expression `
    -Command "$PSSCRIPTROOT/hyperv/removeTempHypervSwitch.ps1"

# Initialize HyperV Ethernet Switch
Invoke-Expression `
    -Command "$PSSCRIPTROOT/hyperv/createTempHypervSwitch.ps1"

# Environment cleanup
Write-Host "
/////////////////////////////////////////////////////////////////
Docker machines cleanup
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
deleteVms $DockerSwarmNodeNames

Write-Host "
/////////////////////////////////////////////////////////////////
Docker swarm cleanup
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
docker swarm leave -f

# Environment initialization
Write-Host "
/////////////////////////////////////////////////////////////////
Docker Swarm initialization...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
docker swarm init

# Creating and starting docker-machine(s)
Write-Host "
/////////////////////////////////////////////////////////////////
Creating and starting docker-machine(s)...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
createAndStartVms $DockerSwarmNodeNames

## TODO - Need to understand why certs are copied two time to each docker node

# Creating and starting docker-machine(s)
Write-Host "
/////////////////////////////////////////////////////////////////
Listing docker-machine(s)...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
docker-machine ls

# Useful things area...

# Shutdown entire environment...
Read-Host "
/////////////////////////////////////////////////////////////////
Press any key to terminate Docker Swarm Stack App ($AppName)
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

# Environment cleanup
Write-Host "
/////////////////////////////////////////////////////////////////
Docker machines cleanup
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
deleteVms $DockerSwarmNodeNames

Write-Host "
/////////////////////////////////////////////////////////////////
Docker swarm cleanup
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
docker swarm leave -f

# Clean HyperV Ethernet Switch
Invoke-Expression `
    -Command "$PSSCRIPTROOT/hyperv/removeTempHypervSwitch.ps1"
