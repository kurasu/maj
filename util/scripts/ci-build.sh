#!/usr/bin/env bash

set  -euo pipefail
IFS=$'\n\t'


SCRIPT_NAME="$(basename $0)"
SCRIPT_PATH_DIR="$(dirname $0)"
cd ${SCRIPT_PATH_DIR}
cd ../../
PROJECT_ROOT="$(pwd)"

COMMAND=${1:-all}
if [[ $# -gt 0 ]]; then
  shift;
fi

function build_project() {
  chmod +x mvnw
  echo "$(pwd): ./mvnw clean compile ***"
  ./mvnw clean compile -DskipTests=true -Dmaven.javadoc.skip=true -B -V $@
}

function test_project() {
  chmod +x mvnw
  echo "$(pwd): ./mvnw clean test ***"
  ./mvnw clean test jacoco:prepare-agent jacoco:report sonar:sonar -B -V $@
}

function package_project() {
  chmod +x mvnw
  echo "$(pwd): ./mvnw clean install ***"
  ./mvnw clean install -Dsonar.skip=true -DskipTests=true -B -V $@
}

function clean_project() {
  chmod +x mvnw
  echo "$(pwd): ./mvnw clean ***"
  ./mvnw clean -B -V $@ || exit 1
}

function print_usage(){
  echo "SCRIPT_NAME [command [args]] "
  echo " "
  echo "  commands"
  echo "    build    Clean the project and build the project"
  echo "    test     Clean the project and run all tests"
  echo "    package  Clean the project and package all tests"
  echo "    clean    Clean the project"
  echo "    all      execute all commands in the order: build, test, package, clean"
  echo " "
  echo "  args       the args are passed to maven"
}

if [[ $# -lt 1 ]]; then
  ARGS=(
    -P sonar
    -s $PROJECT_ROOT/util/configurations/settings.xml
    -Dmaven.javadoc.skip=true
    --quiet
  )
else
  ARGS=("${@}")
fi

case $COMMAND in
  build)
    build_project     ${ARGS[@]}
  ;;

  test)
    test_project      ${ARGS[@]}
  ;;

  package)
    package_project   ${ARGS[@]}
  ;;

  clean)
    clean_project     ${ARGS[@]}
  ;;

  all)
    echo "all" && {
      build_project   ${ARGS[@]}
      test_project    ${ARGS[@]}
      package_project ${ARGS[@]}
      # clean_project   ${ARGS[@]}
    }
   ;;

   *)
    echo "Unknown option '$COMMAND'"
    print_usage
    exit 1
esac

