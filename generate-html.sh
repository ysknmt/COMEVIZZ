#!/bin/bash
cd $TRAVIS_BUILD_DIR/gitbook
gitbook install
gitbook build
cd ..

