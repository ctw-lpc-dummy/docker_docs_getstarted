# Variable zone
$DockerFileLocation = "$PSSCRIPTROOT/../containerFiles/"

$ImageName = "friendlyhello"

# Annoucement
Write-Host "
/////////////////////////////////////////////////////////////////
Building And Running And Cleaning the image:
    -> Name: ""$ImageName""
    -> At Location: ""$DockerFileLocation""
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

# Purging the deceased containers
Write-Host "
/////////////////////////////////////////////////////////////////
Killing existent related container images...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

$ContainerIds = (docker container ls --all --quiet --filter ancestor=$ImageName)

if ($ContainerIds) {
    docker container stop --time 15 $ContainerIds
    docker container rm $ContainerIds
}

# Building a new image from the "Dockerfile"
Write-Host "
/////////////////////////////////////////////////////////////////
Building image...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

# docker build --quiet -t $ImageName $DockerFileLocation
docker build -t $ImageName $DockerFileLocation

# Creating and starting from the image
Write-Host "
/////////////////////////////////////////////////////////////////
Creating and starting the container...
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

docker run --interactive --rm --tty -p 4000:80 $ImageName

Write-Host "

/////////////////////////////////////////////////////////////////
Container based on image with the name ""$ImageName"" was removed
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"