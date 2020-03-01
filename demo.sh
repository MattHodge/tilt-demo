#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

kubectx kind-kind || true
kind delete cluster || true
kind create cluster

echo "Demo Ready"
