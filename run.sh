#!/bin/sh
#
# This script is used to filter the error information in '/var/log/messages', and the related error information can be specified in the variable ERROR_INFO.
#
# Exit
#   0 - success
#   !0 - fail
# CHANGE LOG
#   20180914 	Lank	 Initial Version
#*************************************************properties**********************************#
DEST_DIR=/tmp/tmp

#*************************************************function************************************#
main(){
[ ! -d $DEST_DIR ] && mkdir $DEST_DIR
ansible-playbook run_fetch.yml
}
main
