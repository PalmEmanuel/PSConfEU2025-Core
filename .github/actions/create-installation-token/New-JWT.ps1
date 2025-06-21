param(
    [Parameter(Mandatory)]
    [string]$ClientId,

    [Parameter(Mandatory)]
    [string]$PrivateKey
)

# Create the RSA object and import the private key
$RSA = [System.Security.Cryptography.RSA]::Create()
$RSA.ImportFromPem($PrivateKey)

# Assemble the header
$Header = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json @{
                alg = 'RS256'
                typ = 'JWT'
            }))).TrimEnd('=').Replace('+', '-').Replace('/', '_');

# Assemble the payload
$Payload = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes((ConvertTo-Json @{
                iat = [System.DateTimeOffset]::UtcNow.AddSeconds(-10).ToUnixTimeSeconds()
                exp = [System.DateTimeOffset]::UtcNow.AddMinutes(10).ToUnixTimeSeconds()
                iss = $ClientId 
            }))).TrimEnd('=').Replace('+', '-').Replace('/', '_');

# Sign the token
$Signature = [Convert]::ToBase64String($RSA.SignData([System.Text.Encoding]::UTF8.GetBytes("$Header.$Payload"), [System.Security.Cryptography.HashAlgorithmName]::SHA256, [System.Security.Cryptography.RSASignaturePadding]::Pkcs1)).TrimEnd('=').Replace('+', '-').Replace('/', '_')
$JWT = "$Header.$Payload.$Signature"

Write-Output $JWT