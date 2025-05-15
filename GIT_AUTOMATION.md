# Git Automation Setup

This project includes an automated Git commit and push script to ensure all changes are tracked and can be easily rolled back if needed.

## How to Use Auto-Git-Push

1. Make sure you have committed all your current changes as a starting point.
2. Run the PowerShell script in a separate terminal window:

```powershell
# Navigate to the project directory
cd G:\BUILDING\docs\my_app

# Run the auto-git-push script
.\auto-git-push.ps1
```

3. The script will automatically:
   - Check for changes every 25 minutes (configurable)
   - Ignore specified file patterns (logs, temp files, etc.)
   - Commit any detected changes with a timestamped message
   - Push the changes to your remote repository
   - Log all operations to auto-git-push.log

4. To stop the script, press `Ctrl+C` in the terminal window.

## Customizing the Script

You can pass parameters to customize the script behavior:

```powershell
.\auto-git-push.ps1 -CommitMessagePrefix "Custom message: " -CheckIntervalSeconds 1800 -Branch "development" -IgnorePattern "*.log|*.tmp|build/*" -PushImmediately $false
```

Available parameters:

- `CommitMessagePrefix`: Prefix for commit messages (default: "Auto-commit: ")
- `CheckIntervalSeconds`: How often to check for changes in seconds (default: 1500, which is 25 minutes)
- `Branch`: The branch to push changes to (default: "main")
- `GitPath`: Path to the Git executable (default: "git")
- `IgnorePattern`: Pipe-separated list of file patterns to ignore (default: "*.log|*.tmp|.vs/|.idea/")
- `PushImmediately`: Whether to push changes immediately after commit (default: $true)

## Rolling Back Changes

If you need to roll back to a previous state:

1. View the commit history:

   ```
   git log --oneline
   ```

2. Roll back to a specific commit:

   ```
   git reset --hard <commit-hash>
   ```

3. Force-push the rollback if needed:

   ```
   git push --force origin <branch-name>
   ```

Remember to always create backup branches before performing forced operations.

## Best Practices for Auto-Git-Push

1. **Commit Frequency**:
   - The default 25-minute interval balances between frequent backups and avoiding excessive commits
   - Use shorter intervals during critical development phases
   - Use longer intervals for routine work

2. **File Exclusions**:
   - Exclude build artifacts, logs, and temporary files using the `-IgnorePattern` parameter
   - Always exclude files containing sensitive information
   - Consider adding large binary files to .gitignore instead

3. **Log Monitoring**:
   - Check auto-git-push.log periodically to verify commit history
   - The log file automatically rotates when it reaches 5MB

4. **Remote Synchronization**:
   - If working in a team, consider setting `-PushImmediately $false` to accumulate commits locally
   - Then manually push at logical break points to avoid disrupting others

5. **Script Performance**:
   - For large repositories, increase the check interval to reduce system impact
   - The script has minimal impact when running in the background
