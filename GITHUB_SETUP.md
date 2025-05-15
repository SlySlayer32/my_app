# Setting Up GitHub Repository

Follow these steps to connect your local repository to GitHub:

## 1. Create a new GitHub repository

1. Go to [GitHub](https://github.com/) and sign in to your account.
2. Click on the "+" icon in the upper right corner and select "New repository".
3. Name your repository (e.g., "my-image-processing-app").
4. Choose whether to make it public or private.
5. Do NOT initialize the repository with a README, .gitignore, or license (since you're connecting an existing repository).
6. Click "Create repository".

## 2. Connect your local repository to GitHub

After creating the repository, GitHub will show you commands to connect your existing repository. Run the following commands in your PowerShell terminal:

```powershell
# Navigate to your project directory
cd G:\BUILDING\docs\my_app

# Add the GitHub repository as a remote
git remote add origin https://github.com/YOUR-USERNAME/my-image-processing-app.git

# Push your existing repository to GitHub
git push -u origin main
```

Replace `YOUR-USERNAME` with your actual GitHub username and `my-image-processing-app` with your repository name.

## 3. Start the auto-git-push script

Once your repository is connected to GitHub, you can start the auto-git-push script:

```powershell
.\auto-git-push.ps1
```

This will automatically commit and push changes to your GitHub repository at regular intervals.

## Using Personal Access Token (if required)

If you're using HTTPS and GitHub requires a personal access token:

1. Go to GitHub Settings → Developer Settings → Personal Access Tokens → Tokens (classic)
2. Click "Generate new token"
3. Give it a name, select appropriate scopes (at minimum: "repo")
4. Click "Generate token" and copy the token
5. When prompted for a password during git push, use the token instead of your GitHub password
