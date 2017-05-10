#!/bin/sh
set -e

docker login -p $1 -e unused -u unused $2
