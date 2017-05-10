#!/bin/sh
set -e

$1 -c $2 -- docker login -p $3 -e unused -u unused $4
