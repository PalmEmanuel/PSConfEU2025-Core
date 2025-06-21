param(
	# Comment Params
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
    # Comment Headers
    Accept = 'application/vnd.github+json'
	Authorization = "Bearer $Token"
}

# Comment Body
$Body = @{ body = $Body } | ConvertTo-Json

$Params = @{
    # Comment Splat Params
	Uri = "https://api.github.com/repos/$Repo/issues/$IssueNumber/comments"
	Headers = $Headers
	Method = 'Post'
	Body = $Body
	ContentType = 'application/json'
}

Invoke-RestMethod @Params