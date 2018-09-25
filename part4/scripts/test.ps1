$DockerGetStartedSwitchName = "DockerGetStartedSwitch"

Invoke-Expression `
    -Command "$PSSCRIPTROOT/createTempHypervSwitch.ps1"

docker-machine `
    create `
        -d hyperv `
        --hyperv-virtual-switch $DockerGetStartedSwitchName `
        myvm1



# docker-machine `
#     regenerate-certs `
#         --force `
#         myvm1

#         docker-machine `
#     start `
#         myvm1

# docker-machine `
#     create `
#         -d hyperv `
#         --hyperv-virtual-switch $DockerGetStartedSwitchName `
#         myvm2

# docker-machine `
#     start `
#         myvm2
    
# docker-machine `
#     regenerate-certs `
#         --force `
#         myvm2

# docker-machine ls

# docker-machine `
#     ssh `
#         myvm1 `
#         "docker swarm init --advertise-addr <myvm1 ip>"

Invoke-Expression `
    -Command "$PSSCRIPTROOT/removeTempHypervSwitch.ps1"
