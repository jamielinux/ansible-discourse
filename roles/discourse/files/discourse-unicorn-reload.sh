#!/bin/sh
old_pid="$1"
[ "x$old_pid" = "x" ] && exit 1
echo "Start new unicorn master..."
/bin/kill -USR2 $old_pid
/bin/sleep 10s
if [ ! -f '/var/www/discourse/tmp/pids/unicorn.pid' ]; then
    /bin/sleep 10s
    [ ! -f '/var/www/discourse/tmp/pids/unicorn.pid' ] && exit 1
fi
new_pid=`/usr/bin/head -c 5 '/var/www/discourse/tmp/pids/unicorn.pid'`
[ "x$new_pid" = "x" ] && exit 1
[ "$old_pid" -eq "$new_pid" ] && exit 1
echo "Stopping old unicorn workers."
/bin/kill -WINCH $old_pid
/bin/sleep 10s
echo "Stopping old unicorn master."
/bin/kill -QUIT $old_pid
