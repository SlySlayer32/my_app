# Git Rollback Guide

This guide provides step-by-step instructions for rolling back to previous versions of your code when needed.

## Viewing Your Git History

To see the history of commits:

```powershell
# View commit history with timestamps
git log --pretty=format:"%h - %an, %ar : %s"

# View a simplified log
git log --oneline

# View log with changed files
git log --stat
```

## Simple Rollback Options

### Option 1: Revert the latest commit (Creates a new commit that undoes changes)

```powershell
# Revert the most recent commit
git revert HEAD

# Revert a specific commit
git revert <commit-hash>
```

### Option 2: Reset to a previous commit (Warning: Rewrites history)

```powershell
# Soft reset - keeps changes in staging area
git reset --soft <commit-hash>

# Mixed reset - unstages changes (default)
git reset <commit-hash>

# Hard reset - discards all changes (CAUTION!)
git reset --hard <commit-hash>
```

## Advanced Rollback Scenarios

### Roll back to a specific date/time

```powershell
# Find commit closest to a specific date
git rev-list -n 1 --before="2025-05-10 15:00" HEAD

# Then reset to that commit
git reset --hard <commit-hash>
```

### Create a backup branch before rolling back

```powershell
# Create a backup branch at current state
git branch backup-YYYY-MM-DD

# Check the backup branch exists
git branch

# Now safe to perform reset operations
git reset --hard <commit-hash>
```

### Roll back specific files

```powershell
# Restore a specific file from a previous commit
git checkout <commit-hash> -- path/to/file.dart

# Restore a directory from a previous commit
git checkout <commit-hash> -- path/to/directory/
```

## After Rolling Back

If you've used a `git reset --hard` or any other history-changing operation and need to update the remote repository:

```powershell
# Force push (CAUTION: Overwrites remote history)
git push --force origin main
```

**WARNING**: Force pushing rewrites remote history and can cause problems for other collaborators. Only use when necessary and coordinate with your team.
