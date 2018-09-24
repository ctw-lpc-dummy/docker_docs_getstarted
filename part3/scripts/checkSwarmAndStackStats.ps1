# Variable zone
$AppName = "getstartedlab"
$ServiceName = $("$AppName" + "_web")

$DockerHubUserName = "luispedrocalcadactw"
$DockerHubRepository = "get-started"
$DockerHubRepositoryTag = "latest"
$DockerHubRepositoryPseudoImageName = $("$DockerHubUserName" + "/" + "$DockerHubRepository")
$DockerHubRepositoryPseudoPath = $("$DockerHubRepositoryPseudoImageName" + ":" + "$DockerHubRepositoryTag")

# Annoucement
$SelectedOption = Read-Host "
/////////////////////////////////////////////////////////////////
Docker Swarm / Stack stats viewer:
    -> AppName: ""$AppName""
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Choose an option:
    -> 0 -> Service view -> inspect 
    -> 1 -> Service view -> logs
    -> 2 -> Container view -> list
    -> 3 -> Container view -> stats (without filtering) / Improvements TBD (foreach filtered ids AS input)

"

# If mode :D
if ($SelectedOption -eq 0) {
    docker service inspect $ServiceName
} elseif ($SelectedOption -eq 1) {
    docker service ps $ServiceName
} elseif ($SelectedOption -eq 2) {
    docker container ls --filter ancestor=$DockerHubRepositoryPseudoPath
} elseif ($SelectedOption -eq 3) {
    docker container stats
} else {
    Write-Host "
    Invalid option!!!!
    
    Have a nice day!!! ;) :) :D
    
    "
}
