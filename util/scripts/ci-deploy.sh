#!/usr/bin/env bash

set  -euo pipefail
IFS=$'\n\t'

SCRIPT_NAME="$(basename $0)"
SCRIPT_PATH_DIR="$(dirname $0)"
cd ${SCRIPT_PATH_DIR}
cd ../../
PROJECT_ROOT="$(pwd)"

RUN_ENVIRONMENT="local"
DEPLOYMENT="snapshot"

function prepare_jenkins() {
  echo "prepare_jenkins $1"
}
#     openssl aes-256-cbc -K $encrypted_0f4ee0d3c2e7_key -iv $encrypted_0f4ee0d3c2e7_iv -in codesigning.asc.enc -out codesigning.asc -d
function prepare_travis() {
  if [[ "${TRAVIS_PULL_REQUEST}" == 'false' ]]; then
    openssl aes-256-cbc \
      -K ${encrypted_0f4ee0d3c2e7_key} \
      -iv ${encrypted_0f4ee0d3c2e7_iv} \
      -in util/configurations/codesigning.asc.enc \
      -out util/configurations/codesigning.asc \
      -d

    gpg --fast-import util/configurations/codesigning.asc
  else
    echo "Can't deploy on pull request from travis"
    exit 1
  fi
}

function prepare_local() {
  echo "prepare_local $1";
}

function do_deploy() {
  echo "do_deploy to $1"
  chmod +x ./mvnw
  ./mvnw clean deploy -s ./util/configurations/settings.xml -P gpg-sign,sign,build-extras -DskipTests=true -Dsonar.skip=true
}

if [[ $# -gt 0 ]]; then
  RUN_ENVIRONMENT=$1
fi

if [[ $# -gt 1 ]]; then
  DEPLOYMENT=$2
fi

case ${RUN_ENVIRONMENT} in

  jenkins)
    prepare_jenkins ${DEPLOYMENT}
  ;;

  travis)
    prepare_travis ${DEPLOYMENT}
  ;;

  local)
    prepare_local ${DEPLOYMENT}
  ;;

  *)
    echo "Run environment '${RUN_ENVIRONMENT}' is not supported"
    exit 1
  ;;

esac

do_deploy ${DEPLOYMENT}