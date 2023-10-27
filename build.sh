#!/usr/bin/env bash

# Could be run like this: $ ./build.sh $(git tag --sort=committerdate | tail -1)
if [[ ! $1 =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-[a-z]+)?$ ]]; then
	echo "Invalid version format. Please use v0.0.0-foo"
	exit 1
fi
pseudo_version="$1"
readonly pseudo_version

if ! docker build -t mint . -f Dockerfile; then
	echo "Failed to build docker image"
	exit 1
fi

tag=ghcr.io/edgelesssys/mint:"$pseudo_version"
if docker tag mint:latest "$tag"; then
	echo "Successfully built docker image: $tag"
fi
