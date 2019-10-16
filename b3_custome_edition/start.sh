#!/bin/bash
function startServer(){
NUMSECONDS=`expr $(date +%s)`
until python b3_run.py ; do
let DIFF=(`date +%s` - "$NUMSECONDS")
if [ "$DIFF" -gt 15 ]; then
NUMSECONDS=`expr $(date +%s)`
echo "Server 'python b3_run.py ' crashed with exit code $?.  Respawning..." >&2 
fi
sleep 3
done
let DIFF=(`date +%s` - "$NUMSECONDS")
if [ ! -e "SERVER_STOPPED" ] && [ "$DIFF" -gt 15 ]; then
startServer
fi
}
startServer
