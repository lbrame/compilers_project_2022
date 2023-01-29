#!/bin/bash

TESTFILE="input.txt"

if [[ ! -f ./ast ]]
then
    echo "Binary not found! Compiling."
    make
fi

./ast $TESTFILE
