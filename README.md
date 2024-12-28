# CreateGitRepo_script

## GitHub Repository Creator Script

This script automates the creation of a new GitHub repository and links it to a local Git repository. It dynamically retrieves your GitHub username, initializes a Git repository in a new directory, creates a `README.md` file, and pushes the initial commit to GitHub using SSH.

## Features

- Dynamically fetches your GitHub username using a Personal Access Token (PAT).
- Creates a new directory for each repository to prevent accidental Git initialization in unintended locations.
- Automates the GitHub repository creation using the GitHub REST API.
- Uses SSH to link the local repository with GitHub for secure and convenient access.

## Prerequisites

- **Git**: Ensure Git is installed and configured on your system.
- **jq**: The script uses `jq` for JSON processing. Install it using:
    ```bash
    sudo apt-get install jq
    ```
- **Personal Access Token (PAT)**: Generate a PAT with at least `repo` scope for repository creation. [GitHub Docs: Creating a personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token).

## How to Use

1. Save the script as `create-repo.sh`.
2. Make it executable:
     ```bash
     chmod +x create-repo.sh
     ```
3. Run the script, providing the repository name as an argument:
     ```bash
     ./create-repo.sh my-new-repo
     ```
     If no name is provided, the script will prompt you for one.
4. Enter your GitHub Personal Access Token when prompted.

The script will:
- Create a directory named `my-new-repo`.
- Initialize a Git repository.
- Create a `README.md` file.
- Push the initial commit to a new GitHub repository.

## Example Output

```plaintext
Authenticated as GitHub user: Bamidele0102
Repository 'my-new-repo' has been created and pushed to GitHub successfully in the directory 'my-new-repo'!
```

## Notes

- The script uses SSH for remote repository links. Ensure your SSH keys are configured for GitHub. [GitHub Docs: Generating SSH keys](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
- Temporary files created during the script's execution (e.g., API responses) are automatically cleaned up.

## Troubleshooting

- **Error: 'jq' is not installed.**
    Install `jq` using:
    ```bash
    sudo apt-get install jq
    ```
- **Error: Unable to fetch GitHub username.**
    Check that your PAT is valid and has the required `repo` scope.
- **Error: Directory already exists.**
    Choose a unique repository name or manually delete the existing directory.

## License

This script is licensed under the MIT License.

---

### Instructions to Use:
1. Copy both the script and the `README.md` file into your project directory.
2. Make the script executable and use it to create new repositories easily.
3. Optionally, you can include the `LICENSE` file if needed.

Let me know if you want to include any additional files or instructions!
