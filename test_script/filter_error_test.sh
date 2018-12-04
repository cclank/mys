#!/bin/sh
#
# This script is used to filter the error information in '/var/log/messages', and the related error information can be specified in the variable ERROR_INFO.
# For test
# 
# Exit
#   0 - success
#   !0 - fail
#
# CHANGE LOG
#   20180914    Lank     Initial Version
#*************************************************properties**********************************#
MSG_FILE=/var/log/messages
# test ERROR_INFO
ERROR_INFO="HCPREQUEST on"
#ERROR_INFO="I/O error"
LOG_TEMP=/var/log/tmp
FIND_ERROR=$(grep -i "$ERROR_INFO" $MSG_FILE)

#*************************************************function************************************#
filter_error(){

        DATE_LIST=$(echo "${FIND_ERROR}"|cut -c1-6|uniq)
        [ ! -d $LOG_TEMP ] && mkdir $LOG_TEMP
        IFS=$'\n'
        for DATE_ID in $DATE_LIST
        do
                echo "$FIND_ERROR"|egrep ^"$DATE_ID" >>${LOG_TEMP}/${DATE_ID//\ /\_}.txt
        done
        if [ $?=0 ];then
                echo "The error message was successfully filtered."
        fi
}

#Package files for uploading
tar_file(){

        cd $LOG_TEMP
        tar -zcf /tmp/error_info.tar.gz ./*
}

#clear file: You can comment it out when you test it for check output.
clear_file(){

        rm -rf ${LOG_TEMP}
}

#***********************************************Main*******************************************#
main(){
if [ -r $MSG_FILE ];then
        if [[ -n $FIND_ERROR ]];then
                filter_error
                tar_file
#                clear_file
        else
                echo "No '"${ERROR_INFO}"' error message in '${MSG_FILE}'."
                exit 0
        fi
else
        echo "Unable to read file！ "
        exit 0
fi
}

main
