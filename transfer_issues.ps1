# Fetch issues from the old repository
$oldIssues = Invoke-RestMethod -Uri 'https://api.github.com/repos/tabfloater/tabfloater/issues' -Headers @{ "Authorization" = "Bearer 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" }

# Create issues in the new repository
foreach ($issue in $oldIssues) {
    $body = @{
        title = $issue.title
        body = @"
Originally posted by @$($issue.user.login) in the old repository:

$($issue.body)

---
- Issue created on: $($issue.created_at)
- Number of comments: $($issue.comments)
- Labels: $($issue.labels | ForEach-Object { $_.name }) 
"@
    } | ConvertTo-Json

    Invoke-RestMethod -Method Post -Uri 'https://api.github.com/repos/tabfloater/TabFloater-Feedback/issues' -Headers @{ "Authorization" = "Bearer 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" } -Body $body
}