#!/bin/bash

GH_URL="https://github.com/${GH_ORG}/${GH_REPO}.git"

function setup_repo {
  git remote set-url origin ${GH_URL}
  git remote set-branches --add origin $GH_BRANCH
  git fetch -q
  git config user.name $GH_NAME
  git config user.email $GH_EMAIL
  git config credential.helper "store --file=.git/credentials"
  echo "https://${GH_TOKEN}:x-oauth-basic@github.com" > .git/credentials
  git branch $GH_BRANCH origin/${GH_BRANCH}
  git checkout $GH_BRANCH
}

function cleanup {
  rm .git/credentials
}

function run_test {
  local server=$1
  local report=$2

  echo "Processing server $server"
  refget-compliance report --server $server --no-web --json_path _data/${report}.json
}

setup_repo

run_test "https://refget.herokuapp.com/" "refget-server-perl"
run_test "https://www.ebi.ac.uk/ena/cram/" "ena-server"
run_test "https://refget-insdc.jeremy-codes.com/" "insdc-aws-fargate"
run_test "https://spjb6ejone.execute-api.us-east-2.amazonaws.com/Prod/" "insdc-aws-serverless"

git add .
git commit -m 'Adding test results'
git push origin $GH_BRANCH

cleanup

exit 0