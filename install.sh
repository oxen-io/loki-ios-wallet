#!/bin/bash

mkdir -p Libraries

sh scripts/install_libraries.sh
sh scripts/install_missing_headers.sh
