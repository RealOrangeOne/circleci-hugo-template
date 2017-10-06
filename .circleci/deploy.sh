#!/usr/bin/env bash

set -e

DEPLOY_DIR=deploy

git config --global push.default simple
git config --global user.email $(git --no-pager show -s --format='%ae' HEAD)
git config --global user.name $CIRCLE_USERNAME

echo "Starting deployment to Github Pages"

git clone -q --branch=gh-pages $CIRCLE_REPOSITORY_URL $DEPLOY_DIR

cd $DEPLOY_DIR
rsync -ar --delete ../public/* .

git add -f .
git commit -m "Deploy build $CIRCLE_BUILD_NUM\n[ci skip]" || true
git push -f

echo "Deployment completed."
