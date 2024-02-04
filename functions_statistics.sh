#!/bin/bash

INPUT_FILE=functions_apue
OUTPUT_FILE_TEMPLATE=functions_statistics

>${INPUT_FILE}_temp

sed '/^$/d' $INPUT_FILE > ${INPUT_FILE}_temp

while read LINE
do
	case $LINE in
	\#*)
		;;
	*)
		COUNT_C=`find $1 -name *.c -type f | xargs grep -v "\*" | grep "\<${LINE}\>" | grep "${LINE}(" | wc -l`
		COUNT_H=`find $1 -name *.h -type f | xargs grep -v "\*" | grep -v "^[^\#]" | grep "\<${LINE}\>" | wc -l`
		COUNT=`expr $COUNT_C + $COUNT_H`
		echo "$LINE: $COUNT" | tee -a ${OUTPUT_FILE_TEMPLATE}_temp
	esac
done < ${INPUT_FILE}_temp

OUTPUT_FILE=${OUTPUT_FILE_TEMPLATE}_$1
sort -t: -r -k2 -n ${OUTPUT_FILE_TEMPLATE}_temp > ${OUTPUT_FILE}

rm ${INPUT_FILE}_temp
rm ${OUTPUT_FILE_TEMPLATE}_temp
