#!/bin/bash

#tmp file with timestamp
TMP_FILE="./tmpLog"

function REMOVE_TMP_FILE() {
    rm -rf $TMP_FILE
}

#find project name
function FIND_NAME() {
    PROJECT_NAMES=`find ./ -name *.xcodeproj -exec basename {} \; | head -n 1`
    PROJECT_NAME=""
    for NAME in $PROJECT_NAMES
    do
        PROJECT_NAME=$NAME
    done
}

#creating csv file if it does not exists
function CREATE_TIME_CSV_FILE_IF_NEEDED() {
    FILENAME="${PROJECT_NAME}_buildTime.csv"
    if [ ! -f $FILENAME ]; then
        touch $FILENAME;

        echo "Day:,time(s):,formatted time:, number of builds:" >> $FILENAME;
    fi
}
#Calculate build time
function CALCULATE_TIME() {
    START_TIMESTAMP=`cat $TMP_FILE`
    END_TIMESTAMP=`date +%s`
    RESULT_TIMESTAMP="$((END_TIMESTAMP-START_TIMESTAMP))"
}

#Save info to file
function SAVE_INFO() {

    declare -i NUMBER_OF_BUILDS=1

    DATE=`date +%d-%m-%y`

    SECONDS=$((RESULT_TIMESTAMP % 60))
    MINUTES=$((RESULT_TIMESTAMP / 60))
    HOURS=$((RESULT_TIMESTAMP / 3600))

    LINE=`tail -1 $FILENAME`;
    IFS=',' read -ra ARRAY <<< "$LINE";

    FORMATTED="${HOURS}h ${MINUTES}m ${SECONDS}s"

    if [ ! "${ARRAY[0]}" == "$DATE" ]; then
        echo "${DATE},${RESULT_TIMESTAMP},${FORMATTED},${NUMBER_OF_BUILDS}" >> $FILENAME;
    else

        NUMBER_OF_BUILDS="$((ARRAY[3] + 1))";
        RESULT_TIMESTAMP="$((RESULT_TIMESTAMP + ARRAY[1]))";

        SECONDS=$((RESULT_TIMESTAMP % 60))
        MINUTES=$((RESULT_TIMESTAMP / 60))
        MINUTES=$((MINUTES % 60))
        HOURS=$((RESULT_TIMESTAMP / 3600))

        FORMATTED="${HOURS}h ${MINUTES}m ${SECONDS}s"

        if [ "$DATE" == "${ARRAY[0]}" ]; then
            sed -i '' -e '$ d' $FILENAME
        fi

        echo "${DATE},${RESULT_TIMESTAMP},${FORMATTED},${NUMBER_OF_BUILDS}" >> $FILENAME;
    fi
}

#remove tmp file
function REMOVE_TMP_FILE() {
    rm -rf $TMP_FILE
}

FIND_NAME PROJECT_NAME
CREATE_TIME_CSV_FILE_IF_NEEDED
CALCULATE_TIME
SAVE_INFO
REMOVE_TMP_FILE
