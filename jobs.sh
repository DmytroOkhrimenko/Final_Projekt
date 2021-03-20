#!/bin/bash


TASK_DIR=/home/ubuntu/amasinggrave
TOOL=/home/ubuntu/tools



count=$( ls $TASK_DIR | wc -l )
if(( count==0 )); then
    s3fs amasinggrave ${TASK_DIR} -o passwd_file=${HOME}/.passwd-s3fs
    echo "Bucket is mounted"
else
    echo "Bucket is already mounted"
fi


ls ${TASK_DIR}/*.txt  >/dev/null 2>&1

if [ "$?" -gt 0  ]; then
 echo "No inputs .txt  files in backet. Exit"
 exit 2
fi



LOG=/home/ubuntu/log_file.txt
if [ ! -f $LOG ] ; then
    touch $LOG
fi


cp ${TOOL}/parse.py ${WORK_DIR}/.
cp ${TOOL}/run_g03.sh ${WORK_DIR}/.
chmod +x ${WORK_DIR}/run_g03.sh 




