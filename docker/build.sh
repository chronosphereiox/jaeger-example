#!/usr/bin/env bash

set -e
set -x
~/go/bin/esc -pkg frontend -o ../services/frontend/gen_assets.go -prefix ../services/frontend/web_assets ../services/frontend/web_assets
GOOS=linux GOARCH=amd64 go build -o hotrod-linux ../main.go
docker build . --tag gcr.io/chronosphere-dev/jaeger-example

