# Fetch issues from the old repository
$oldIssues = Invoke-RestMethod -Uri 'https://api.github.com/repos/tabfloater/tabfloater/issues' -Headers @{ "Authorization" = "Bearer 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" }

# Create issues in the new repository
foreach ($issue in $oldIssues) {
    $body = @{
        title = $issue.title
        body = $issue.body
    } | ConvertTo-Json

    Invoke-RestMethod -Method Post -Uri 'https://api.github.com/repos/tabfloater/TabFloater-Feedback/issues' -Headers @{ "Authorization" = "Bearer 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" } -Body $body
}