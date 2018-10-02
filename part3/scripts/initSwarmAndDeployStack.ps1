# Variable zone
$DockerComposeLocation = "$PSSCRIPTROOT/../workbench/docker-compose.yml"

$AppName = "getstartedlab"

# Annoucement
Write-Host "
/////////////////////////////////////////////////////////////////
Docker Swarm deploy:
    -> AppName: ""$AppName""
    -> Docker Compose file Location: ""$DockerComposeLocation""
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

Write-Host "
/////////////////////////////////////////////////////////////////
Docker Swarm initialization...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
docker swarm init

$DockerSwarmInitWaitSecs = 10
Write-Host "
/////////////////////////////////////////////////////////////////
Waiting $DockerSwarmInitWaitSecs seconds...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
Start-Sleep -Seconds $DockerSwarmInitWaitSecs 

Write-Host "
/////////////////////////////////////////////////////////////////
Deploying Docker Swarm Stack App ($AppName) ...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
docker stack deploy -c $DockerComposeLocation $AppName