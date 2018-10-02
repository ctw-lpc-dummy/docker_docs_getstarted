# Variable zone
$DockerComposeLocation = "$PSSCRIPTROOT/../workbench/docker-compose.yml"

$AppName = "getstartedlab"

# Useful things area...
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