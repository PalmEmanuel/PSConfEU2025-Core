param(
	[Parameter(Mandatory)]
	[string]$Token,

	[Parameter(Mandatory)]
	[string]$IssueNumber,

	[Parameter(Mandatory)]
	[string]$Body,

	[Parameter(Mandatory)]
	[string]$Repository
)

$Headers = @{
    Accept = 'application/vnd.github+json'
	Authorization = "Bearer $Token"
}

$Body = @{ body = $Body } | ConvertTo-Json

$Params = @{
    Uri = "https://api.github.com/repos/$Repository/issues/$IssueNumber/comments"
	Headers = $Headers
	Method = 'Post'
	Body = $Body
	ContentType = 'application/json'
}

Invoke-RestMethod @Params