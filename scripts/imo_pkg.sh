#!/bin/bash

set -e

if [ ! -d .git -a -d ../.git ]; then
  cd ..
fi

if [ ! -d .git ]; then
  echo "Run me from the root directory of the project."
fi

set +e
  npm install
set -e

grunt
grunt release

pushd dist &> /dev/null
  echo -n "Enter full version (like 1.8.0-imo2): "
  read version

  tar -xzf *.tar.gz
  rm *.tar.gz
  crnt=$(echo grafana-*)
  if [ "$crnt" != "grafana-${version}" ]; then
    mv $crnt grafana-$version
  fi
  zip -r grafana-$version.zip grafana-$version
  rm -r grafana-$version
popd &> /dev/null

echo "Done! Check dist/grafana-$version.zip"
