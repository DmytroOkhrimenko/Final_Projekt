#!/bin/bash


BUCKET=/home/ubuntu/aws_bucket
WORK_DIR=/home/ubuntu/GaussFiles
TOOL=/home/ubuntu/tools



count=$( ls $BUCKET | wc -l )
if(( count==0 )); then
    s3fs amasinggrave ${BUCKET} -o passwd_file=${HOME}/.passwd-s3fs
    echo "Bucket is mounted"
else
    echo "Bucket is already mounted"
fi


ls ${BUCKET}/*.txt  >/dev/null 2>&1

if [ "$?" -gt 0  ]; then
 echo "No inputs .txt  files in backet. Exit"
 exit 2
fi

LOG=/home/ubuntu/log_file.txt
if [ ! -f $LOG ] ; then
    touch $LOG
fi

WWW='/var/www/html'
cd $WWW
word="писатель"
date >> $LOG
echo "Start search " $word " in bucket" >>$LOG
python3 parse.py $word
echo "End parse date. Save to epam.txt file" >>$LOG
date >> $LOG
RES="RESULTS"
if  [ !  -d $RES ]; then
    mkdir $RES
fi
d=`date +%Y-%m-%d.%H:%M:%S`
mv epam.txt $RES/epam_$d.txt
