#!/bin/bash

rm -r /usr/local/fasill
mkdir -p /usr/local/fasill
cp LICENSE /usr/local/fasill/LICENSE
cp -r src /usr/local/fasill/src
cp -r lattices /usr/local/fasill/lattices
cp fasill /usr/local/bin/fasill
