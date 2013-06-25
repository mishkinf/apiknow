#!/bin/bash -e
source "$HOME/.bashrc"
source .rvmrc

source ./install_gems.sh

./run_tests.rb

RESULT=$?

exit $RESULT
0