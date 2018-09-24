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

Read-Host "
/////////////////////////////////////////////////////////////////
Press any key to terminate Docker Swarm Stack App ($AppName)
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

Write-Host "
/////////////////////////////////////////////////////////////////
Taking down Docker Swarm Stack App ($AppName) ...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
docker stack rm $AppName

Write-Host "
/////////////////////////////////////////////////////////////////
Taking down Docker Swarm (force mode) ...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
docker swarm leave --force