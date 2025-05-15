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
   - Check for changes every 5 minutes (configurable)
   - Commit any detected changes with a timestamped message
   - Push the changes to your remote repository

4. To stop the script, press `Ctrl+C` in the terminal window.

## Customizing the Script

You can pass parameters to customize the script behavior:

```powershell
.\auto-git-push.ps1 -CommitMessagePrefix "Custom message: " -CheckIntervalSeconds 120 -Branch "development"
```

Available parameters:

- `CommitMessagePrefix`: Prefix for commit messages (default: "Auto-commit: ")
- `CheckIntervalSeconds`: How often to check for changes in seconds (default: 300)
- `Branch`: The branch to push changes to (default: "main")
- `GitPath`: Path to the Git executable (default: "git")

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
