Param (
        [Parameter(Mandatory=$false)]
        [string]$pullRequestNumber
    )

if ($null -eq $pullRequestNumber) {
  $currentPrJson = Invoke-Expression 'gh pr view --json number,mergedAt'
} else {
  $currentPrJson = Invoke-Expression 'gh pr view $pullRequestNumber --json number,mergedAt'
}
$currentPr = $currentPrJson | ConvertFrom-Json
$currentPrMergedAt = $currentPr.mergedAt

$allMergedPrsJson = Invoke-Expression 'gh pr list --state=merged --json number,mergedAt,reviewDecision,author,title,url'
$allMergedPrs = $allMergedPrsJson | ConvertFrom-Json
$blockingPrs = $allMergedPrs | Where-Object { $_.reviewDecision -ne "APPROVED"}

if ($null -ne $currentPrMergedAt) {
    $blockingPrs = $blockingPrs | Where-Object { $_.mergedAt -lt $currentPrMergedAt}
} 

$blockingPrs | Sort-Object mergedAt | Select-Object number,@{Name="author"; Expression={$_.author.name}},mergedAt,reviewDecision,title,url
