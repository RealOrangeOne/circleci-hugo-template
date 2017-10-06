#!/usr/bin/env bash

set -e

DEPLOY_DIR=deploy

git config --global user.email $(git --no-pager show -s --format='%ae' HEAD)
git config --global user.name $CIRCLE_USERNAME

echo -e "Starting deployment to Github Pages\n"
# Using token clone gh-pages branch
git clone --branch=gh-pages $CIRCLE_REPOSITORY_URL $DEPLOY_DIR

# Go into directory and copy data we're interested in to that directory
cd $DEPLOY_DIR
rsync -ar --delete ../public/* .

# Add, commit and push files
git add -f .
git commit -m "Deploy build $CIRCLE_BUILD_NUM [ci-skip]"
git push -f origin gh-pages

echo -e "Deployment completed.\n"
