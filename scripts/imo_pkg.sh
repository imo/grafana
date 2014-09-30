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

pushd tmp &> /dev/null
  echo -n "Enter full version (like 1.8.0-imo2): "
  read version

  unzip *.zip
  rm *.zip *.tar.gz
  mv grafana-* grafana-$version
  zip -r grafana-$version.zip grafana-$version
  rm -r grafana-$version
popd &> /dev/null

echo "Done! Check tmp/grafana-$version.zip"
