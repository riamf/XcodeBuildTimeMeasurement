#!/bin/bash

#tmp file to log timestamp

TMP_FILE="./tmpLog";

#remove tmp file if it exists
if [ -f $TMP_FILE ]; then
    rm -rf $TMP_FILE;
fi

#create tmp file
touch $TMP_FILE;

#writing timestamp to temporary file
echo "`date +%s`" >> $TMP_FILE;
