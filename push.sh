#!/bin/sh

LC=$(git rev-parse --short HEAD)
docker build -t stokwell/webbapp:${LC}
docker push stokwell/webapp:${LC}
