#! /usr/bin/env bash
echo "Running entrypoint script..."

gh extension install dlvhdr/gh-dash

exec "$@"
