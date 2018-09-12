#!/bin/sh

EXEC_NAME=mcpd
EXEC_PATH=/bin
USER=root

start()
{
	$EXEC_PATH/$EXEC_NAME &
}

stop()
{
	killall $EXEC_NAME
}

reload()
{
	mcpctl reload
}


case "$1" in
	start)
		PID=$(pgrep mcpd)
		if [ "$PID" == "" ] ; then
		echo -e "starting mcpd."
		start
		else
		  echo 'mcpd is already running !!!'
		fi
		exit 0
		;;
		
	stop)
		echo -e "stoping mcpd."
		stop
		exit 0
		;;
	
	restart)
		echo -e "restarting mcpd."
		stop
		start
		exit 0
		;;
		
	reload)
		echo -e "reload mcpd."
		PID=$(pgrep mcpd)
		if [ "$PID" == "" ] ; then
		start
		else
		  reload
		fi
		exit 0
		;;
		
	*)
		echo "$0: unrecognized option $1"
		exit 1
		;;

esac
