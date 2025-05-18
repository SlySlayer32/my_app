# Git Automation Configuration Guide

The auto-git-push script has been optimized for image processing development with the following settings:

## Default Configuration

- Commit interval: 15 minutes (900 seconds)
  - More frequent commits during active development
  - Can be adjusted with `-CheckIntervalSeconds` parameter
  
- Ignored files:
  - Logs and temp files: `*.log`, `*.tmp`
  - IDE folders: `.vs/`, `.idea/`
  - Image files: `*.jpg`, `*.png`, `*.gif`, `*.bmp`
  - Build artifacts: `build/*`, `dist/*`
  - Dependencies: `node_modules/*`, `__pycache__/*`

- Branch protection:
  - Main branch protection enabled by default
  - Requires pull request review for main branch commits
  - Can be bypassed with `-RequireReviewForMain $false`

## Usage Examples

1. Default usage (recommended):

   ```powershell
   .\auto-git-push.ps1
   ```

2. Development mode (5-minute intervals, no review required):

   ```powershell
   .\auto-git-push.ps1 -CheckIntervalSeconds 300 -RequireReviewForMain $false
   ```

3. Production mode (hourly commits, strict protection):

   ```powershell
   .\auto-git-push.ps1 -CheckIntervalSeconds 3600 -RequireReviewForMain $true -Branch "main"
   ```

## Best Practices

1. **Branch Usage**:
   - Use feature branches for development
   - Create pull requests for main branch changes
   - Keep the main branch stable

2. **Commit Frequency**:
   - 15 minutes is the default sweet spot
   - Use shorter intervals (5 min) during critical work
   - Use longer intervals (1 hour) for stable code

3. **File Management**:
   - Large image files should be in a separate data folder
   - Use `.gitignore` for permanent ignore rules
   - Use `-IgnorePattern` for temporary ignores

4. **Review Process**:
   - Enable review requirement for production branches
   - Use pull requests for code review
   - Maintain clean commit history

## Troubleshooting

1. If auto-push fails:
   - Commits are saved locally
   - Check network connection
   - Verify Git credentials
   - Check branch permissions

2. For log rotation:
   - Logs rotate at 5MB
   - Old logs are timestamped
   - Check auto-git-push.log regularly
