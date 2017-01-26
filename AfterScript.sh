DATE=`date +'%Y-%m-%d'`
FILE="./${DATE}_${EXECUTABLE_NAME}.log"
echo $FILE
START="`tail -1 $FILE`"
END="Build end time: `date +'%H-%M-%S'`"
echo "${START} - ${END}"
sed -i '' -e '$ d' $FILE

END_T="`date +%s`"
COUNT="`expr $END_T-$START`"
echo "$((END_T-START)) seconds," >> $FILE
