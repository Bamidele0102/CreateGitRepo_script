#!/bin/bash

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: 'jq' is not installed. Install it using 'sudo apt-get install jq'."
    exit 1
fi

# Get the repository name from the first argument
repoName=$1

# Prompt for a repository name if none is provided
while [ -z "$repoName" ]; do
    read -r -p "Please provide a repository name: " repoName
done

# GitHub authentication
read -r -s -p "Enter your GitHub Personal Access Token: " GITHUB_TOKEN
echo

# Fetch the GitHub username using the token
response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user)
GITHUB_USER=$(echo "$response" | jq -r '.login')

if [ "$GITHUB_USER" == "null" ]; then
    echo "Error: Unable to fetch GitHub username. Check your token and try again."
    exit 1
fi

echo "Authenticated as GitHub user: $GITHUB_USER"

# Create a new directory for the repository
mkdir "$repoName" || { echo "Error: Directory '$repoName' already exists."; exit 1; }
cd "$repoName" || exit

# Create README.md
echo "# $repoName" > README.md

# Initialize a Git repository
git init
git add README.md
git commit -m "Initial commit"

# Create the GitHub repository
create_response=$(curl -s -w "%{http_code}" -o /tmp/github_response.json \
    -H "Authorization: token $GITHUB_TOKEN" \
    -X POST "https://api.github.com/user/repos" \
    -H "Accept: application/vnd.github.v3+json" \
    -d '{"name": "'"$repoName"'", "private": false}')

http_code=$(tail -n1 <<< "$create_response")
response_body=$(cat /tmp/github_response.json)

if [ "$http_code" -ne 201 ]; then
    echo "Error creating repository: $(echo "$response_body" | jq -r '.message')"
    exit 1
fi

# Extract the SSH URL
GIT_URL=$(echo "$response_body" | jq -r '.ssh_url')

# Link the local repository to the remote repository using SSH
git branch -M main
git remote add origin "$GIT_URL"
git push -u origin main

# Clean up temporary files
rm -f /tmp/github_response.json

echo "Repository '$repoName' has been created and pushed to GitHub successfully in the directory '$repoName'!"
