# Auto Git Push Script
# This script continuously monitors your project for changes and commits/pushes them automatically
# Usage: Run this script in a separate PowerShell window while working on your project

param(
    [string]$CommitMessagePrefix = "Auto-commit: ",
    [int]$CheckIntervalSeconds = 1500,  # Default: check every 25 minutes
    [string]$Branch = "main",          # Default branch
    [string]$GitPath = "git",           # Path to git executable
    [string]$IgnorePattern = "*.log|*.tmp|.vs/|.idea/",  # Files to ignore
    [bool]$PushImmediately = $true     # Whether to push immediately after commit
)

$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$currentDate = Get-Date -Format "yyyy-MM-dd"
$currentTimeCounter = 1
$ignoreList = $IgnorePattern -split '\|'

# Create a log file for the auto-commit operations
$logFile = Join-Path $projectPath "auto-git-push.log"
$maxLogSize = 5MB  # Maximum log file size before rotation

# Function to write to both console and log file
function Log-Message {
    param (
        [string]$Message,
        [string]$ForegroundColor = "White"
    )
    
    # Write to console
    Write-Host $Message -ForegroundColor $ForegroundColor
    
    # Write to log file with timestamp
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath $logFile -Append

    # Check log file size and rotate if necessary
    if ((Get-Item $logFile).Length -gt $maxLogSize) {
        $backupLogFile = $logFile + "." + (Get-Date -Format "yyyyMMddHHmmss")
        Move-Item $logFile $backupLogFile
        "Log file rotated at $timestamp" | Out-File -FilePath $logFile
    }
}

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
