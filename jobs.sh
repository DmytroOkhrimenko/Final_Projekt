#!/bin/bash


TASK_DIR=/home/ubuntu/backet
WORK_DIR=/home/ubuntu/GaussFiles
TOOL=/home/ubuntu/tools


#Если директория backet пустая, то монтируем ее. Если нет, то не монтируем.
count=$( ls $TASK_DIR | wc -l )
if(( count==0 )); then
    s3fs boomss ${TASK_DIR} -o passwd_file=${HOME}/.passwd-s3fs
    echo "Bucket is mounted"
else
    echo "Bucket is already mounted"
fi


ls ${TASK_DIR}/*.com  >/dev/null 2>&1

if [ "$?" -gt 0  ]; then
 echo "No inputs .com  files in backet. Exit"
 exit 2
fi



LOG=/home/ubuntu/log_file.txt
if [ ! -f $LOG ] ; then
    touch $LOG
fi


cp ${TOOL}/parse.py ${WORK_DIR}/.
cp ${TOOL}/run_g03.sh ${WORK_DIR}/.
chmod +x ${WORK_DIR}/run_g03.sh 

cd ${TASK_DIR}
for f in $(ls *.com); do
	echo "f : $f" >> $LOG
	mv $f ${WORK_DIR}/${f}
done

cd ${WORK_DIR}
RES="READY"
if [ ! -d $RES ]; then
	mkdir $RES
fi

cp parse.py $RES/.

for f_ in $(ls *.com);do
	#echo " Input file : ${f_}" >> $LOG
        echo $(date) " Start to simulate $f_" >> $LOG
	./run_g03.sh ${f_}
	echo $(date) "End calculate $f_" >> $LOG
done






