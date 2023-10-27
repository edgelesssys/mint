#!/usr/bin/env bash

# Could be run like this: $ ./build.sh $(git tag --sort=committerdate | tail -1)
script_path=$(realpath $0)

if [[ ! "$1" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-[a-z]+)?$ ]]; then
  echo "Invalid version format. Please use v0.0.0-foo"
  exit 1
fi

docker build -t mint . -f Dockerfile
if [[ "$?" -ne 0 ]]; then
  echo "Failed to build docker image"
  exit 1
fi

tag=ghcr.io/edgelesssys/mint:"$pseudo_version"
docker tag mint:latest "$tag"

if [[ "$?" -eq 0 ]]; then
  echo "Successfully built docker image: $tag"
fi
