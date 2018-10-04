param (
    [string]$vmName
)

docker-machine `
    --native-ssh `
    start `
        $vmName