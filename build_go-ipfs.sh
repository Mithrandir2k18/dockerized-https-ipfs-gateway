#!/bin/bash

echo "Building go-ipfs:latest from source. This is only necessary if you're not on amd64!"

git clone https://github.com/ipfs/go-ipfs.git
cd go-ipfs
git fetch --tags
latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)
echo Checking out ${latest_tag}
git checkout ${latest_tag}
# shadowing a registered image is bad practice, but we build from source so it's "acceptable"
docker build . -t ipfs/go-ipfs:latest
cd .. && rm -rf go-ipfs

