DATE=`date +'%Y-%m-%d'`
FILE="./${DATE}_${EXECUTABLE_NAME}.log"
echo $FILE
touch "$FILE" || exit
START="Build start time: `date +'%H-%M-%S'`"
START_T="`date +%s`"
echo $START_T
echo "$START_T" >> $FILE
