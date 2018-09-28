#!/bin/bash

function setup_repo {
  git remote set-url --push origin $REPO
  git remote set-branches --add origin $DEPLOY_BRANCH
  git fetch -q
  git config user.name $GIT_NAME
  git config user.email $GIT_EMAIL
  git config credential.helper "store --file=.git/credentials"
  echo "https://${GH_TOKEN}:x-oauth-basic@github.com" > .git/credentials
  git branch $DEPLOY_BRANCH origin/${DEPLOY_BRANCH}
  git checkout $DEPLOY_BRANCH
}

function cleanup {
  rm .git/credentials
}

function run_test {
  local server=$1
  local report=$2

  echo "Processing server $server"
  refget-compliance report --server $s --no-web --json_path _data/${report}.json
}

setup_repo

run_test "https://refget.herokuapp.com/" "refget-server-perl"
# run_test "https://www.ebi.ac.uk/ena/cram/" "ena-server"

git add .
git commit -m 'Adding test results'
git push origin $DEPLOY_BRANCH

cleanup

exit 0