#!/bin/bash

set -euo pipefail

unset CDPATH

set -x
exec google-chrome --incognito "http://10.40.1.11:8500/"
