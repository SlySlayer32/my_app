# Auto Git Push Script
# This script continuously monitors your project for changes and commits/pushes them automatically
# Usage: Run this script in a separate PowerShell window while working on your project

param(
    [string]$CommitMessagePrefix = "Auto-commit: ",
    [int]$CheckIntervalSeconds = 300,  # Default: check every 5 minutes
    [string]$Branch = "main",          # Default branch
    [string]$GitPath = "git"           # Path to git executable
)

$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$currentDate = Get-Date -Format "yyyy-MM-dd"
$currentTimeCounter = 1

Write-Host "Auto-Git-Push started for: $projectPath" -ForegroundColor Green
Write-Host "Press Ctrl+C to stop the script" -ForegroundColor Yellow
Write-Host "Checking for changes every $CheckIntervalSeconds seconds..." -ForegroundColor Cyan

try {
    while ($true) {
        Set-Location $projectPath
        
        # Check Git status
        $status = & $GitPath status --porcelain
        
        if ($status) {
            $currentTime = Get-Date -Format "HH:mm:ss"
            $commitMessage = "$CommitMessagePrefix$currentDate #$currentTimeCounter [$currentTime]"
            
            Write-Host "`n=== Changes detected at $currentTime ===" -ForegroundColor Yellow
            Write-Host "Files changed:" -ForegroundColor Cyan
            Write-Host $status
            
            # Add all changes
            & $GitPath add --all
            
            # Commit changes
            Write-Host "Committing with message: $commitMessage" -ForegroundColor Cyan
            & $GitPath commit -m $commitMessage
            
            # Push changes
            Write-Host "Pushing to remote repository..." -ForegroundColor Cyan
            & $GitPath push origin $Branch
            
            Write-Host "Changes committed and pushed successfully!" -ForegroundColor Green
            $currentTimeCounter++
        } else {
            Write-Host "." -NoNewline -ForegroundColor Gray
        }
        
        # Wait for the specified interval
        Start-Sleep -Seconds $CheckIntervalSeconds
    }
} catch {
    Write-Host "`nScript interrupted: $_" -ForegroundColor Red
} finally {
    Write-Host "`nAuto-Git-Push stopped." -ForegroundColor Yellow
}
