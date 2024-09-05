#!/bin/bash

# Configuration
REPO_NAME="AhYeaInc"
GIT_URL="https://github.com/spiritartworx/$REPO_NAME.git"
README_FILE="README.md"
LICENSE_FILE="LICENSE.md"
CONTRIBUTING_FILE="CONTRIBUTING.md"
CODE_OF_CONDUCT_FILE="CODE_OF_CONDUCT.md"
DIRECTORY_STRUCTURE=("docs" "scripts" "config")
INITIATIVES=("ahyea.com" "BeatStreetDrummer" "GhostDriver" "LightBeings" "MassiveMind" "FromShadowWithLove")

# Create the main repository directory
mkdir $REPO_NAME
cd $REPO_NAME

# Initialize a new git repository
git init

# Create directories
for DIR in "${DIRECTORY_STRUCTURE[@]}"; do
    mkdir $DIR
done

# Create a README file
cat <<EOL > $README_FILE
# Ah Yea Inc.

## Overview
Welcome to the Ah Yea Inc. repository. This is the central hub for project coordination, documentation, and shared code for our various initiatives.

### Initiatives
EOL

# Add links to initiative repositories in README
for initiative in "${INITIATIVES[@]}"; do
    echo "- **[$initiative](https://github.com/spiritartworx/$initiative)**" >> $README_FILE
done

cat <<EOL >> $README_FILE
## Purpose
This repository contains core documentation, configuration, and shared components for Ah Yea Inc. and its initiatives.

## Directories
- **docs/**: Documentation for shared components and design systems.
- **scripts/**: Shared scripts for automation and deployment.
- **config/**: Configuration files relevant across multiple initiatives.

## Contributing
We welcome contributions! Please check out our [Contributing Guidelines](CONTRIBUTING.md) for more information.

## License
This project is licensed under the [Creative Commons Non-Commercial, No Derivatives (CC BY-NC-ND)](LICENSE.md) license.

## Code of Conduct
Please review our [Code of Conduct](CODE_OF_CONDUCT.md) to understand our community expectations.
EOL

# Create a LICENSE file
cat <<EOL > $LICENSE_FILE
# Creative Commons Non-Commercial, No Derivatives (CC BY-NC-ND)

This license allows for distribution but does not permit commercial use or modifications.

## Note from the Creator:
This work is dedicated to Tony, whose passion for sharing music and creating spaces where artists could freely express themselves inspired this initiative.

I hope this work inspires you to create beautiful things and connect with others. For more information and updates, please visit AhYea.com, where you can also explore other initiatives currently in development. I warmly invite you to reach out and collaborate as we build a creative and impactful community together.
EOL

# Create a CONTRIBUTING file
cat <<EOL > $CONTRIBUTING_FILE
# Contributing to Ah Yea Inc.
We welcome contributions to help us make our initiatives a success. Please review our guidelines and reach out for collaborative opportunities.
EOL

# Create a CODE_OF_CONDUCT file
cat <<EOL > $CODE_OF_CONDUCT_FILE
# Code of Conduct
Our Code of Conduct outlines the expectations for behavior within our community. We strive to create a respectful and inclusive environment for all participants.
EOL

# Create and initialize initiative repositories
for initiative in "${INITIATIVES[@]}"; do
    mkdir ../$initiative
    cd ../$initiative
    git init
    touch README.md
    git add README.md
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin "https://github.com/spiritartworx/$initiative.git"
    git push -u origin main
    cd ../$REPO_NAME
done

# Commit and push the main repository to GitHub
git add .
git commit -m "Initial commit with project setup"
git branch -M main
git remote add origin $GIT_URL
git push -u origin main

echo "Repository setup completed and pushed to $GIT_URL"
