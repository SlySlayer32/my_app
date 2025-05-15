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

Log-Message "Auto-Git-Push started for: $projectPath" "Green"
Log-Message "Press Ctrl+C to stop the script" "Yellow"
Log-Message "Checking for changes every $($CheckIntervalSeconds / 60) minutes..." "Cyan"
Log-Message "Ignoring files matching: $IgnorePattern" "Cyan"

# Function to check if a file should be ignored
function Should-Ignore {
    param (
        [string]$FilePath
    )
    foreach ($pattern in $ignoreList) {
        if ($pattern -and $FilePath -like $pattern) {
            return $true
        }
    }
    return $false
}

try {
    # First, check if remote is configured
    $remoteExists = & $GitPath remote -v
    if (-not $remoteExists) {
        Log-Message "Warning: No remote repository configured. Commits will be local only." "Yellow"
    }

    # Main monitoring loop
    while ($true) {
        Set-Location $projectPath
        
        # Check Git status
        $status = & $GitPath status --porcelain
        
        if ($status) {
            $filesToCommit = @()
            $ignoredFiles = @()
            
            # Process each file in the status output
            foreach ($line in $status -split "`n") {
                $statusCode = $line.Substring(0, 2).Trim()
                $filePath = $line.Substring(3).Trim()
                
                if (Should-Ignore $filePath) {
                    $ignoredFiles += $filePath
                } else {
                    $filesToCommit += $filePath
                }
            }
            
            # Only proceed if there are files to commit
            if ($filesToCommit.Count -gt 0) {
                $currentTime = Get-Date -Format "HH:mm:ss"
                $commitMessage = "$CommitMessagePrefix$currentDate #$currentTimeCounter [$currentTime]"
                
                Log-Message "`n=== Changes detected at $currentTime ===" "Yellow"
                Log-Message "Files to commit:" "Cyan"
                foreach ($file in $filesToCommit) {
                    Log-Message "  $file" "White"
                }
                
                if ($ignoredFiles.Count -gt 0) {
                    Log-Message "Ignored files:" "Gray"
                    foreach ($file in $ignoredFiles) {
                        Log-Message "  $file" "Gray"
                    }
                }
                
                # Stage all files except ignored ones
                foreach ($file in $filesToCommit) {
                    & $GitPath add $file
                }
                
                # Commit changes
                Log-Message "Committing with message: $commitMessage" "Cyan"
                & $GitPath commit -m $commitMessage
                
                # Push changes if configured to do so and remote exists
                if ($PushImmediately -and $remoteExists) {
                    Log-Message "Pushing to remote repository..." "Cyan"
                    $pushResult = & $GitPath push origin $Branch 2>&1
                    
                    if ($LASTEXITCODE -eq 0) {
                        Log-Message "Changes committed and pushed successfully!" "Green"
                    } else {
                        Log-Message "Push failed. Error: $pushResult" "Red"
                        Log-Message "Commits are saved locally and will be pushed on next successful attempt." "Yellow"
                    }
                } else {
                    Log-Message "Changes committed locally!" "Green"
                }
                
                $currentTimeCounter++
            } else {
                Log-Message "All changed files match ignore patterns, nothing to commit." "Gray"
            }
        } else {
            Write-Host "." -NoNewline -ForegroundColor Gray
        }
        
        # Wait for the specified interval
        Start-Sleep -Seconds $CheckIntervalSeconds
    }
} catch {
    Log-Message "`nScript interrupted: $_" "Red"
} finally {
    Log-Message "`nAuto-Git-Push stopped." "Yellow"
}
