#! /usr/bin/env bash
# This script is used to build the devcontainer image. It should be run from the root of the repository.

## CD to project root
cd "$(dirname "$(dirname "$(realpath "$0")")")"

WORKSPACE_FOLDER=./src
IMAGE_NAME=brpaz/devcontainer:local-dev

if [ ! command -v devcontainer &> /dev/null ]; then
	echo "devcontainer command not found. Please install the devcontainer CLI tool."
	exit 1
fi

# Build the image
devcontainer build --workspace-folder $WORKSPACE_FOLDER --image-name $IMAGE_NAME
