Set-Location -Path $PSScriptRoot

Write-Host "============================================"
Write-Host " bmc-sys-website を GitHub へ Push します"
Write-Host "============================================"
Write-Host ""

git status
Write-Host ""

$commitMsg = Read-Host "コミットメッセージを入力してください"
if ([string]::IsNullOrWhiteSpace($commitMsg)) {
    Write-Host "[ERROR] コミットメッセージが空です。処理を中止します。"
    Read-Host "Enterキーで終了します"
    exit 1
}

git add -A
git commit -m $commitMsg
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] コミットする変更がないか、コミットに失敗しました。"
    Read-Host "Enterキーで終了します"
    exit 1
}

Write-Host ""
Write-Host "GitHubへpushしています..."
git push origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] git push に失敗しました。ネットワークや認証を確認してください。"
    Write-Host "リモートに新しい変更がある場合は、先に git pull origin main を実行してください。"
    Write-Host "（force push は行わないでください）"
    Read-Host "Enterキーで終了します"
    exit 1
}

Write-Host ""
Write-Host "============================================"
Write-Host " 完了しました！最新コミット:"
git log -1 --oneline
Write-Host "============================================"
Read-Host "Enterキーで終了します"
