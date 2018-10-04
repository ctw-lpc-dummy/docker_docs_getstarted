param (
    [string]$vmName
)

docker-machine `
    --native-ssh `
    regenerate-certs `
        --force `
        $vmName