param(
    [Parameter(Mandatory)]
    [string]$JWT,

    [Parameter(Mandatory)]
    [string]$Account
)

$Headers = @{
    Accept = 'application/vnd.github+json'
    Authorization = "Bearer $JWT"
}

$Installations = Invoke-RestMethod -Uri 'https://api.github.com/app/installations' -Headers $Headers
$InstallationId = ($Installations | Where-Object { $_.account.login -eq $Account }).id

# Get an installation token
$TokenResponse = Invoke-RestMethod -Uri "https://api.github.com/app/installations/$InstallationId/access_tokens" -Headers $Headers -Method Post
$InstallationToken = $TokenResponse.token

Write-Output $InstallationToken