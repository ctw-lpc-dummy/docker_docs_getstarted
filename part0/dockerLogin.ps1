Write-Host "
/////////////////////////////////////////////////////////
| Docker Login Helper
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
"

Write-Host "
---> Please type your username and press ""ENTER"" key:
"
$loginUsername = Read-Host

Write-Host "
---> Please type your password and press ""ENTER"" key:
"
$loginPassword = Read-Host

Write-Host "
---> Logging in ...
"

docker login --username "$loginUsername" --password "$loginPassword"