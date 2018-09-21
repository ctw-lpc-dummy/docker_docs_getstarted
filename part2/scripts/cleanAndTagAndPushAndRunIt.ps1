# Variable zone
$ImageName = "friendlyhello"
$DockerHubUserName = "luispedrocalcadactw"
$DockerHubRepository = "get-started"
$DockerHubRepositoryTag = "latest"
$DockerHubRepositoryPseudoImageName = $("$DockerHubUserName" + "/" + "$DockerHubRepository")
$DockerHubRepositoryPseudoPath = $("$DockerHubUserName" + "/" + "$DockerHubRepository" + ":" + "$DockerHubRepositoryTag")

# Annoucement
Write-Host "
/////////////////////////////////////////////////////////////////
Share the image on Docker Hub:
    -> Name: ""$ImageName""
Within repo:
    -> Username: ""$DockerHubUserName""
    -> Repository: ""$DockerHubRepository""
    -> Tag: ""$DockerHubRepositoryTag""
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

# Purging the deceased containers
Write-Host "
/////////////////////////////////////////////////////////////////
(1st of all) killing existent related container images...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

$ContainerIds = (docker container ls --all --quiet --filter ancestor=$DockerHubRepositoryPseudoImageName)

if ($ContainerIds) {
    docker container stop --time 15 $ContainerIds
    docker container rm $ContainerIds
}


# Image tagging
Write-Host "
/////////////////////////////////////////////////////////////////
Add tag to the image created previously 
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
docker tag $ImageName $DockerHubRepositoryPseudoPath

# Creating and starting from the image
Write-Host "
/////////////////////////////////////////////////////////////////
Push to Docker Hub the tagged image
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"
docker push $DockerHubRepositoryPseudoPath

# Creating and starting from the image
Write-Host "
/////////////////////////////////////////////////////////////////
Creating and starting the container (obtained from Docker Hub)...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

docker run --interactive --rm --tty -p 4000:80 $DockerHubRepositoryPseudoPath

Write-Host "

/////////////////////////////////////////////////////////////////
(Docker Hub based) downloaded container was removed
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"