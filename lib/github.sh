#!/usr/bin/env bash

set -euo pipefail

#######################################
# Retrieve the details of the pull request from the github api
#
# @see https://docs.github.com/en/rest/reference/pulls#get-a-pull-request
#
# Globals:
#   GITHUB_OAUTH
#   GITHUB_READ_OAUTH
#   GITHUB_TRIAGE_OAUTH
#   CIRCLE_PROJECT_USERNAME
#   CIRCLE_PROJECT_REPONAME
#   CIRCLE_PR_NUMBER
#
# Return:
#   The PR details
#######################################
github.pull.get () {
    if [[ -n  ${GITHUB_TRIAGE_OAUTH:=''} ]];
      then local OAUTH=$GITHUB_TRIAGE_OAUTH
    elif [[ -n  ${GITHUB_READ_OAUTH:=''} ]];
      then local OAUTH=$GITHUB_READ_OAUTH
    else
      local OAUTH=$GITHUB_OAUTH
    fi

    curl -H "Authorization: token $OAUTH" -H "Accept: application/vnd.github.shadow-cat-preview+json" \
        -S "https://api.github.com/repos/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/pulls/$CIRCLE_PR_NUMBER"
}

#######################################
# Extracts the URL from a pull request details response
#
# Arguments:
#   1 the pull request details response to extract the URL from
#######################################
github.pull.url.get () {
  echo "$1" | jq '.head.repo.git_url' | sed -e 's/^"//' -e 's/"$//'
}

#######################################
# Extracts the ref from a pull request details response
#
# Arguments:
#   1 the pull request details response to extract the ref from
#######################################
github.pull.ref.get () {
  echo "$1" | jq '.head.ref' | sed -e 's/^"//' -e 's/"$//'
}
